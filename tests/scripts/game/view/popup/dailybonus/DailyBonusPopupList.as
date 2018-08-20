package game.view.popup.dailybonus
{
   import feathers.layout.TiledRowsLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledAlphaGradientList;
   
   public class DailyBonusPopupList extends GameScrolledAlphaGradientList
   {
       
      
      public function DailyBonusPopupList(param1:GameScrollBar)
      {
         super(param1);
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.useSquareTiles = false;
         layout = _loc1_;
         _loc1_.gap = 10;
         _loc1_.horizontalGap = 6;
         _loc1_.paddingTop = 12;
         _loc1_.paddingBottom = 12;
      }
   }
}
