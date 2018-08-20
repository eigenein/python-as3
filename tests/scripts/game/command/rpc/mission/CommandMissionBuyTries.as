package game.command.rpc.mission
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.mission.PlayerEliteMissionEntry;
   
   public class CommandMissionBuyTries extends CostCommand
   {
       
      
      private var mission:PlayerEliteMissionEntry;
      
      public function CommandMissionBuyTries(param1:PlayerEliteMissionEntry)
      {
         super();
         this.mission = param1;
         rpcRequest = new RpcRequest("missionBuyTries");
         rpcRequest.writeParam("id",param1.id);
         _cost = param1.eliteTries.refillCost;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.missions.missionEliteRefill(mission.id);
         super.clientExecute(param1);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:CommandRequirement = super.prerequisiteCheck(param1);
         var _loc3_:Boolean = param1.missions.eliteMissionCanRefill(mission.id);
         _loc2_.invalid = !_loc3_;
         return _loc2_;
      }
   }
}
