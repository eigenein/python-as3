package game.command.rpc.mission
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.pve.mission.MissionDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.gui.tutorial.Tutorial;
   
   public class CommandMissionStart extends CostCommand
   {
       
      
      private var mission:MissionDescription;
      
      private var heroes:Vector.<PlayerHeroEntry>;
      
      public function CommandMissionStart(param1:MissionDescription, param2:Vector.<PlayerHeroEntry>)
      {
         var _loc5_:int = 0;
         super();
         this.heroes = param2;
         this.mission = param1;
         _cost = param1.tryCost;
         var _loc4_:Array = [];
         var _loc3_:int = param2.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_] = param2[_loc5_].id;
            _loc5_++;
         }
         rpcRequest = new RpcRequest("missionStart");
         rpcRequest.writeParam("id",param1.id);
         rpcRequest.writeParam("heroes",_loc4_);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         Tutorial.events.triggerEvent_missionStart(mission);
         param1.missions.missionStart(mission,heroes,result.body);
      }
   }
}
