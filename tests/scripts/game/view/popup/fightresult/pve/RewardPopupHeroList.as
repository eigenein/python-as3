package game.view.popup.fightresult.pve
{
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   
   public class RewardPopupHeroList extends List
   {
       
      
      private var __itemRendererType:Class;
      
      public function RewardPopupHeroList(param1:Class)
      {
         __itemRendererType = param1;
         super();
      }
      
      override protected function initialize() : void
      {
         itemRendererType = __itemRendererType;
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         _loc1_.gap = 10;
         layout = _loc1_;
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
         clipContent = false;
      }
   }
}
