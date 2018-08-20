package game.view.popup.hero
{
   import feathers.layout.TiledRowsLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import starling.display.DisplayObject;
   
   public class HeroList extends GameScrolledList
   {
       
      
      public function HeroList(param1:GameScrollBar, param2:DisplayObject, param3:DisplayObject)
      {
         super(param1,param2,param3);
         useFloatCoordinates = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.useSquareTiles = false;
         layout = _loc1_;
         _loc1_.gap = 6;
         var _loc2_:int = 12;
         _loc1_.paddingBottom = _loc2_;
         _loc1_.paddingTop = _loc2_;
      }
   }
}
