package game.view.popup.tower.screen
{
   public class TowerScreenChestFloorClip extends TowerScreenFloorListItemRendererClip
   {
       
      
      public function TowerScreenChestFloorClip()
      {
         super();
      }
      
      override protected function createButton() : void
      {
         button = new TowerScreenChestButton();
      }
   }
}
