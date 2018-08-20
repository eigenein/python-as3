package game.command.rpc.arena
{
   import game.battle.controller.MultiBattleResult;
   import game.command.rpc.mission.MissionBattleResultValueObject;
   import game.mechanics.clan_war.mediator.ClanWarBattleResultValueObject;
   import game.mechanics.dungeon.mediator.DungeonBattleResultValueObject;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.tower.TowerBattleResultValueObject;
   
   public class BattleResultValueObjectFactory
   {
       
      
      public function BattleResultValueObjectFactory()
      {
         super();
      }
      
      public static function parseArenaLogEntry(param1:Object) : ArenaBattleResultValueObject
      {
         var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
         _loc2_.source = param1;
         _loc2_.replayId = param1.id;
         _loc2_.typeId = param1.typeId;
         _loc2_.userId = param1.userId;
         _loc2_.win = param1.result.win;
         if(!param1.result.invalid)
         {
            _loc2_.newPlace = param1.result.newPlace;
            _loc2_.oldPlace = param1.result.oldPlace;
            _loc2_.stars = param1.result.stars;
         }
         else
         {
            _loc2_.invalid = true;
         }
         _loc2_.startTime = param1.startTime;
         _loc2_.endTime = param1.endTime;
         _loc2_.result = new MultiBattleResult();
         _loc2_.result.attackers = parseTeam(param1.attackers);
         _loc2_.result.defenders = parseTeam(param1.defenders[0]);
         return _loc2_;
      }
      
      public static function parseArenaCommandResult(param1:Object) : ArenaBattleResultValueObject
      {
         trace(JSON.stringify(param1));
         var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
         if(param1.battles && param1.battles.length > 0)
         {
            _loc2_.source = param1.battles[0];
            _loc2_.replayId = _loc2_.source.id;
         }
         _loc2_.newPlace = param1.state.arenaPlace;
         _loc2_.typeId = param1.typeId;
         _loc2_.userId = param1.userId;
         _loc2_.win = param1.win;
         return _loc2_;
      }
      
      public static function createMissionResult(param1:MultiBattleResult) : MissionBattleResultValueObject
      {
         var _loc2_:MissionBattleResultValueObject = new MissionBattleResultValueObject();
         _loc2_.result = param1;
         _loc2_.stars = param1.result.stars;
         _loc2_.win = param1.result.win;
         return _loc2_;
      }
      
      public static function createTowerResult(param1:MultiBattleResult, param2:Object) : TowerBattleResultValueObject
      {
         var _loc3_:TowerBattleResultValueObject = new TowerBattleResultValueObject();
         _loc3_.result = param1;
         _loc3_.stars = param1.result.stars;
         _loc3_.win = param1.result.win;
         return _loc3_;
      }
      
      public static function createClanWarBattleResult(param1:MultiBattleResult) : ClanWarBattleResultValueObject
      {
         var _loc2_:ClanWarBattleResultValueObject = new ClanWarBattleResultValueObject();
         _loc2_.result = param1;
         _loc2_.stars = param1.result.stars;
         _loc2_.win = param1.result.win;
         return _loc2_;
      }
      
      public static function createDungeonResult(param1:MultiBattleResult, param2:Object) : DungeonBattleResultValueObject
      {
         var _loc3_:DungeonBattleResultValueObject = new DungeonBattleResultValueObject();
         _loc3_.result = param1;
         _loc3_.stars = param1.result.stars;
         _loc3_.win = param1.result.win;
         return _loc3_;
      }
      
      public static function createResult(param1:MultiBattleResult, param2:Object) : BattleResultValueObject
      {
         var _loc3_:BattleResultValueObject = new BattleResultValueObject();
         _loc3_.result = param1;
         _loc3_.stars = param1.result.stars;
         _loc3_.win = param1.result.win;
         return _loc3_;
      }
      
      private static function parseTeam(param1:Object) : Vector.<UnitEntryValueObject>
      {
         var _loc2_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.push(UnitUtils.createEntryValueObjectFromRawData(_loc3_));
         }
         return _loc2_;
      }
   }
}
