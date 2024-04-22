package com.example.back.repositories;

import com.example.back.entities.Conversation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ConversationRepo extends JpaRepository<Conversation,Integer> {
}
