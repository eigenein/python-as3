package game.mechanics.dungeon.model
{
   import game.mechanics.dungeon.model.state.DungeonFloorElement;
   import game.mechanics.dungeon.storage.DungeonFloorType;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   
   public class PlayerDungeonBattleEnemy
   {
       
      
      private var _index:int;
      
      private var _floor:PlayerDungeonBattleFloor;
      
      public const heroes:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
      
      protected var _power:int;
      
      private var _defenderType:DungeonFloorElement;
      
      private var _attackerType:DungeonFloorElement;
      
      public function PlayerDungeonBattleEnemy(param1:Object, param2:PlayerDungeonBattleFloor, param3:int)
      {
         super();
         _index = param3;
         _floor = param2;
         _defenderType = DungeonFloorElement.getByIdent(param1.defenderType);
         _attackerType = DungeonFloorElement.getByIdent(param1.attackerType);
         _power = param1.power;
         parseHeroes(param1.team);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get floor() : PlayerDungeonBattleFloor
      {
         return _floor;
      }
      
      public function get floorType() : DungeonFloorType
      {
         return _floor.type;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function get defenderType() : DungeonFloorElement
      {
         return _defenderType;
      }
      
      public function get attackerType() : DungeonFloorElement
      {
         return _attackerType;
      }
      
      protected function parseHeroes(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            heroes.push(UnitUtils.createEntryValueObjectFromRawData(_loc2_));
         }
      }
   }
}
