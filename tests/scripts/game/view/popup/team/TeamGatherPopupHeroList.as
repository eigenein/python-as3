package game.view.popup.team
{
   import feathers.controls.List;
   import feathers.layout.TiledRowsLayout;
   import idv.cjcat.signals.Signal;
   
   public class TeamGatherPopupHeroList extends List
   {
       
      
      private var _selectSignal:Signal;
      
      public function TeamGatherPopupHeroList()
      {
         super();
      }
      
      public function get selectSignal() : Signal
      {
         return _selectSignal;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.gap = 8;
         itemRendererType = TeamGatherPopupHeroRenderer;
         layout = _loc1_;
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "on";
         interactionMode = "mouse";
      }
   }
}
