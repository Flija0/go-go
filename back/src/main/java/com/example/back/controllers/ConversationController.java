package com.example.back.controllers;

import com.example.back.entities.Conversation;
import com.example.back.serviceInterfaces.IConversationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/conversation")
public class ConversationController {

    IConversationService iConversationService;

    @PostMapping("/add/{userid1}/{userid2}")
    Conversation addConversation(@PathVariable int userid1, @PathVariable int userid2){
        return iConversationService.addConversation(userid1, userid2);
    }

    @GetMapping("/getAllConversationsForTheAuthentifiedUser/{id}")
    List<Conversation> getAllConversationsForTheAuthentifiedUser(@PathVariable int id){
        return iConversationService.getAllConversationsForTheAuthentifiedUser(id);
    }

    @GetMapping("/getSelectedConversation/{id}")
    Conversation getSelectedConversation(@PathVariable int id){
        return iConversationService.getSelectedConversation(id);
    }
}
