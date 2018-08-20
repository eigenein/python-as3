package game.view.popup.hero
{
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   
   public class HeroListPanelInventoryList extends List
   {
       
      
      public function HeroListPanelInventoryList()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 2;
         layout = _loc1_;
         itemRendererType = HeroListPanelInventoryListPanel;
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
         clipContent = false;
      }
   }
}
