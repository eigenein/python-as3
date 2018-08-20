package game.view.popup.mission
{
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   
   public class MissionEnterPopupEnemyList extends List
   {
       
      
      public function MissionEnterPopupEnemyList()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 5;
         _loc1_.verticalAlign = "middle";
         itemRendererType = MissionEnterPopupEnemyRenderer;
         layout = _loc1_;
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
      }
   }
}
