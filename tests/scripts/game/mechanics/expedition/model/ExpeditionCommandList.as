package game.mechanics.expedition.model
{
   import game.command.CommandManager;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   
   public class ExpeditionCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function ExpeditionCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function expeditionGet() : CommandExpeditionGet
      {
         var _loc1_:CommandExpeditionGet = new CommandExpeditionGet();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function expeditionSendHeroes(param1:int, param2:Vector.<int>) : CommandExpeditionSendHeroes
      {
         var _loc3_:CommandExpeditionSendHeroes = new CommandExpeditionSendHeroes(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function expeditionFarm(param1:ExpeditionValueObject) : CommandExpeditionFarm
      {
         var _loc2_:CommandExpeditionFarm = new CommandExpeditionFarm(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
   }
}
