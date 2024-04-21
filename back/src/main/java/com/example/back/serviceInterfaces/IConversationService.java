package com.example.back.serviceInterfaces;

import com.example.back.entities.Conversation;
import com.example.back.entities.User;

import java.util.List;

public interface IConversationService {
    Conversation addConversation(int userid1, int userid2);
    List<Conversation> getAllConversationsForTheAuthentifiedUser(int id);
    Conversation getSelectedConversation(int id);
}
