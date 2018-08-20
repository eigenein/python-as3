package game.view.popup.tower.screen
{
   public class TowerScreenBuffFloorClip extends TowerScreenFloorListItemRendererClip
   {
       
      
      public function TowerScreenBuffFloorClip()
      {
         super();
      }
      
      override protected function createButton() : void
      {
         button = new TowerScreenAltarButton();
      }
   }
}
