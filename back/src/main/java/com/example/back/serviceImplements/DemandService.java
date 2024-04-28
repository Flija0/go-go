package com.example.back.serviceImplements;

import com.example.back.entities.*;
import com.example.back.repositories.*;
import com.example.back.serviceInterfaces.IDemandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DemandService implements IDemandService {

    @Autowired
    DemandRepo demandRepo;

    @Autowired
    UserRepo userRepo;

    @Autowired
    ConversationRepo conversationRepo;

    @Autowired
    RideRepo rideRepo;

    @Autowired
    MessageRepo messageRepo;

    private boolean isToday(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);
    }

    private boolean isTomorrow(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR) + 1;
    }



    @Override
    public Demand addDemand(int userid, int rideid) {
        User user = userRepo.findById(userid).orElse(null);
        if(user == null) return null;
        Ride ride = rideRepo.findById(rideid).orElse(null);
        if(ride == null) return null;
        Demand demand = new Demand();
        demand.setUser(user);
        demand.setRide(ride);
        demand.setStatus(Status.Waiting);

        Conversation conversation = new Conversation();
        conversation.setFirstUser(demand.getUser());
        conversation.setSecondUser(demand.getRide().getCreator());
        conversation.setCreatedAt(new Date());


        Conversation conversationExist = conversationRepo.findAll().stream().filter(conversation1 -> conversation1.getFirstUser().getId() == demand.getUser().getId() && conversation1.getSecondUser().getId() == demand.getRide().getCreator().getId()
                || conversation1.getFirstUser().getId() == demand.getRide().getCreator().getId() && conversation1.getSecondUser().getId() == demand.getUser().getId()).findFirst().orElse(null);

        if(conversationExist == null){
            conversationRepo.save(conversation);
        }

        //add message
        Message message = new Message();
        //message body that i have accepted your demand
        message.setBody("Salut, j'ai une demande de covoiturage pour vous.");
        message.setSender(demand.getUser());
        if(conversationExist == null){
            message.setConversation(conversation);
        }else{
            message.setConversation(conversationExist);
        }
        message.setCreatedAt(new Date());
        //save message
        messageRepo.save(message);

        return demandRepo.save(demand);
    }

    @Override
    public List<Demand> getAllDemandsForTheRideCreator(int id) {

        return demandRepo.findAll().stream().filter(demand -> demand.getRide().getCreator().getId() == id &&
             demand.getStatus().equals(Status.Waiting)
        ).collect(Collectors.toList());
    }

    @Override
    public Demand getSelectedDemand(int id) {
        return demandRepo.findById(id).orElse(null);
    }

    @Override
    public Demand ChangeDemandStatus(int id, String status) {
        Demand demand = demandRepo.findById(id).orElse(null);
        if(demand == null) return null;
        demand.setStatus(Status.valueOf(status));

        if(status.equals("Accepted")){
            demand.getRide().setNumberOfSeats(demand.getRide().getNumberOfSeats() - 1);
            demand.getUser().setConsumptionExpected(demand.getUser().getConsumptionExpected() + demand.getRide().getConsumption());


            userRepo.save(demand.getUser());
            rideRepo.save(demand.getRide());



            Conversation conversation = new Conversation();
            conversation.setFirstUser(demand.getUser());
            conversation.setSecondUser(demand.getRide().getCreator());
            conversation.setCreatedAt(new Date());


            Conversation conversationExist = conversationRepo.findAll().stream().filter(conversation1 -> conversation1.getFirstUser().getId() == demand.getUser().getId() && conversation1.getSecondUser().getId() == demand.getRide().getCreator().getId()
                    || conversation1.getFirstUser().getId() == demand.getRide().getCreator().getId() && conversation1.getSecondUser().getId() == demand.getUser().getId()).findFirst().orElse(null);

            if(conversationExist == null){
                conversationRepo.save(conversation);
            }

            //add message
            Message message = new Message();
            //message body that i have accepted your demand
            message.setBody("Salut, j'ai accepté votre demande de covoiturage.");
            message.setSender(demand.getRide().getCreator());
            if(conversationExist == null){
                message.setConversation(conversation);
            }else{
                message.setConversation(conversationExist);
            }
            message.setCreatedAt(new Date());
            //save message
            messageRepo.save(message);

        }

        return demandRepo.save(demand);
    }
}
