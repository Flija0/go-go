package com.example.back.controllers;

import com.example.back.entities.Message;
import com.example.back.serviceInterfaces.IMessageService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/message")
public class MessageController {

    IMessageService iMessageService;

    @PostMapping("/add/{senderId}/{conversationId}")
    Message addMessage(@RequestParam String body, @PathVariable int senderId, @PathVariable int conversationId){
        return iMessageService.addMessage(body, senderId, conversationId);
    }
    @GetMapping("/get/{id}")
    List<Message> getAllMessagesForThatConversation(@PathVariable int id){
        return iMessageService.getAllMessagesForThatConversation(id);
    }
}
