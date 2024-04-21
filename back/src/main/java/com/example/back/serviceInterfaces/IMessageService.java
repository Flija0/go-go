package com.example.back.serviceInterfaces;

import com.example.back.entities.Message;

import java.util.List;

public interface IMessageService {

    Message addMessage(String body, int senderId, int conversationId);

    List<Message> getAllMessagesForThatConversation(int id);
}
