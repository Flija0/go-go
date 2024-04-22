package com.example.back.serviceImplements;

import com.example.back.entities.Conversation;
import com.example.back.entities.User;
import com.example.back.repositories.ConversationRepo;
import com.example.back.repositories.UserRepo;
import com.example.back.serviceInterfaces.IConversationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ConversationService implements IConversationService {

    @Autowired
    ConversationRepo conversationRepo;

    @Autowired
    UserRepo userRepo;

    @Override
    public Conversation addConversation(int userid1, int userid2) {

        User user1 = userRepo.findById(userid1).orElse(null);
        User user2 = userRepo.findById(userid2).orElse(null);
        if(user1 == null || user2 ==null ) return null;

        Conversation conversation = new Conversation();
        conversation.setCreatedAt(new Date());
        conversation.setFirstUser(user1);
        conversation.setSecondUser(user2);
        return conversationRepo.save(conversation);
    }

    @Override
    public List<Conversation> getAllConversationsForTheAuthentifiedUser(int id) {
        return conversationRepo.findAll().stream().filter(conversation -> conversation.getFirstUser().getId() == id || conversation.getSecondUser().getId() == id).collect(Collectors.toList());
    }

    @Override
    public Conversation getSelectedConversation(int id) {
        return conversationRepo.findById(id).orElse(null);
    }
}
