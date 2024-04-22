package com.example.back.serviceImplements;

import com.example.back.entities.Conversation;
import com.example.back.entities.Message;
import com.example.back.entities.User;
import com.example.back.repositories.ConversationRepo;
import com.example.back.repositories.MessageRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IMessageService;
import com.pusher.rest.Pusher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
public class MessageService implements IMessageService {

    @Autowired
    MessageRepo messageRepo;

    @Autowired
    UserRepo userRepo;

    @Autowired
    ConversationRepo conversationRepo;


    @Override
    public Message addMessage(String body, int senderId, int conversationId) {

        User user = userRepo.findById(senderId).orElse(null);
        Conversation conversation = conversationRepo.findById(conversationId).orElse(null);

        if(user == null  || conversation == null) return null;

        if(conversation.getFirstUser().getId() != senderId && conversation.getSecondUser().getId() != senderId) return null;

        Message message = new Message();

        message.setSender(user);
        message.setConversation(conversation);
        message.setBody(body);
        message.setCreatedAt(new Date());

        //real-time
        Pusher pusher = new Pusher("1791390", "fabd281453b94b3c02f6", "227bbea53c99b601cd4b");
        pusher.setCluster("eu");
        pusher.setEncrypted(true);

        pusher.trigger(String.valueOf(conversationId),"incoming-message", Collections.singletonMap("message", body));

        return messageRepo.save(message) ;
    }

    @Override
    public List<Message> getAllMessagesForThatConversation(int id) {
        return conversationRepo.findById(id).get().getMessageList();
    }
}
