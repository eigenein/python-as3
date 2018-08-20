package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattleEntry;
   import game.mechanics.clan_war.mediator.log.ClanWarLogWarEntry;
   import game.mechanics.clan_war.model.ClanWarDayValueObject;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.model.user.UserInfo;
   
   public class CommandClanWarGetDayHistory extends RPCCommandBase
   {
       
      
      private var day:ClanWarDayValueObject;
      
      private var avgLevel:int;
      
      private var _log:ClanWarLogWarEntry;
      
      private var _attacker:ClanWarParticipantValueObject;
      
      private var _defender:ClanWarParticipantValueObject;
      
      public function CommandClanWarGetDayHistory(param1:ClanWarDayValueObject, param2:ClanWarParticipantValueObject, param3:ClanWarParticipantValueObject)
      {
         super();
         this.day = param1;
         rpcRequest = new RpcRequest("clanWarGetDayHistory");
         rpcRequest.writeParam("season",int(param1.season));
         rpcRequest.writeParam("day",int(param1.day));
         _attacker = param2;
         _defender = param3;
      }
      
      public function get log() : ClanWarLogWarEntry
      {
         return _log;
      }
      
      override protected function successHandler() : void
      {
         var _loc4_:Array = result.body.attack;
         var _loc3_:Array = result.body.defence;
         var _loc6_:Object = result.body.users;
         var _loc1_:Object = result.body.replays;
         avgLevel = result.body.avgLevel;
         _loc6_ = createUsersMap(_loc6_);
         _loc1_ = createReplayMap(_loc1_);
         var _loc5_:Vector.<ClanWarLogBattleEntry> = parseAttack(_loc4_,_loc6_,_loc1_);
         var _loc2_:Vector.<ClanWarLogBattleEntry> = parseAttack(_loc3_,_loc6_,_loc1_);
         _log = new ClanWarLogWarEntry(day,_loc5_,_loc2_,_attacker,_defender);
         super.successHandler();
      }
      
      private function parseAttack(param1:Array, param2:Object, param3:Object) : Vector.<ClanWarLogBattleEntry>
      {
         var _loc4_:* = null;
         var _loc5_:Vector.<ClanWarLogBattleEntry> = new Vector.<ClanWarLogBattleEntry>();
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc6_ in param1)
         {
            _loc4_ = new ClanWarLogBattleEntry();
            _loc4_.parseRawData(_loc6_,param2,param3);
            _loc5_.push(_loc4_);
         }
         return _loc5_;
      }
      
      private function createUsersMap(param1:Object) : Object
      {
         var _loc4_:* = null;
         var _loc2_:Object = {};
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc4_ = new UserInfo();
            _loc2_[_loc3_] = _loc4_;
            _loc4_.parse(param1[_loc3_]);
         }
         return _loc2_;
      }
      
      private function createReplayMap(param1:Object) : Object
      {
         var _loc2_:Object = {};
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_[_loc3_.id] = _loc3_;
         }
         return _loc2_;
      }
   }
}
