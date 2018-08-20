package game.mechanics.dungeon.popup.floor
{
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   
   public class DungeonBattleFloorClip extends DungeonFloorClipBase
   {
       
      
      public function DungeonBattleFloorClip()
      {
         super();
      }
      
      public function getBattleDisplayClip() : DungeonBattleButtonDisplayBase
      {
         return null;
      }
      
      public function createBattleButton(param1:DungeonFloorValueObject) : void
      {
      }
   }
}
