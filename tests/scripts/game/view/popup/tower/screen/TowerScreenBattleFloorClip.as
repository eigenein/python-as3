package game.view.popup.tower.screen
{
   public class TowerScreenBattleFloorClip extends TowerScreenFloorListItemRendererClip
   {
       
      
      public function TowerScreenBattleFloorClip()
      {
         super();
      }
      
      override protected function createButton() : void
      {
         button = new TowerScreenBattleDoorButton();
      }
   }
}
