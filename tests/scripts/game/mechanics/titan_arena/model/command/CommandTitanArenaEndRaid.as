package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mechanics.titan_arena.model.TitanArenaRaidBattleItem;
   import game.model.user.Player;
   
   public class CommandTitanArenaEndRaid extends CostCommand
   {
       
      
      private var _battles:Vector.<TitanArenaRaidBattleItem>;
      
      public function CommandTitanArenaEndRaid(param1:Object)
      {
         _battles = new Vector.<TitanArenaRaidBattleItem>();
         super();
         rpcRequest = new RpcRequest("titanArenaEndRaid");
         rpcRequest.writeParam("results",param1);
      }
      
      public function get hasRaidResult() : Boolean
      {
         return !invalidBattle;
      }
      
      public function get invalidBattle() : Boolean
      {
         return result.body.error != null;
      }
      
      public function get battles() : Vector.<TitanArenaRaidBattleItem>
      {
         return _battles;
      }
      
      public function get place() : int
      {
         return result.body.place;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         _reward = new RewardData();
         var _loc7_:Vector.<PlayerTitanArenaEnemy> = param1.titanArenaData.rivals;
         var _loc5_:Object = result.body.results;
         var _loc4_:int = _loc7_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc6_ = _loc7_[_loc2_];
            _loc3_ = _loc5_[_loc6_.id];
            if(_loc3_)
            {
               _battles.push(new TitanArenaRaidBattleItem(_loc6_,_loc3_));
               if(_loc3_.reward)
               {
                  _reward.addRawData(_loc3_.reward);
               }
            }
            _loc2_++;
         }
         super.clientExecute(param1);
      }
   }
}
