package game.command.rpc.quest
{
   import game.command.CommandManager;
   import game.model.user.quest.PlayerQuestEntry;
   
   public class QuestCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function QuestCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function questFarm(param1:PlayerQuestEntry) : CommandQuestFarm
      {
         var _loc2_:CommandQuestFarm = new CommandQuestFarm(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function questGetAll() : CommandQuestGetAll
      {
         var _loc1_:CommandQuestGetAll = new CommandQuestGetAll();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function questGetAllQuestsAndEvents() : CommandGetAllQuestsAndEvents
      {
         var _loc1_:CommandGetAllQuestsAndEvents = new CommandGetAllQuestsAndEvents();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
   }
}
