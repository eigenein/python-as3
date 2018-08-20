package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandTowerStartBattle extends RPCCommandBase
   {
       
      
      private var heroes:Vector.<PlayerHeroEntry>;
      
      private var difficulty:TowerBattleDifficulty;
      
      public function CommandTowerStartBattle(param1:Vector.<PlayerHeroEntry>)
      {
         var _loc4_:int = 0;
         super();
         this.heroes = param1;
         var _loc3_:Array = [];
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = param1[_loc4_].id;
            _loc4_++;
         }
         rpcRequest = new RpcRequest("towerStartBattle");
         rpcRequest.writeParam("heroes",_loc3_);
      }
      
      public function setupDifficulty(param1:TowerBattleDifficulty) : void
      {
         if(this.difficulty)
         {
            return;
            §§push(trace("установка сложности уже добавлена в этот запрос"));
         }
         else
         {
            var _loc2_:RpcRequest = new RpcRequest("towerChooseDifficulty");
            _loc2_.writeParam("difficulty",param1.value);
            _loc2_.writeRequest(this.rpcRequest);
            this.rpcRequest = _loc2_;
            this.difficulty = param1;
            return;
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:* = undefined;
         super.clientExecute(param1);
         if(rpcRequest.name == "towerStartBattle")
         {
            _loc2_ = result.body;
         }
         else
         {
            _loc2_ = result.data["towerStartBattle"];
         }
         param1.tower.startBattle(heroes,_loc2_);
         if(difficulty)
         {
            param1.tower.chooseDifficulty(difficulty);
         }
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
