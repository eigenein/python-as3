package game.view.gui.components
{
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   import game.view.popup.fightresult.pve.MissionRewardPopupRewardRenderer;
   
   public class RewardList extends List
   {
       
      
      public function RewardList()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 5;
         itemRendererType = MissionRewardPopupRewardRenderer;
         layout = _loc1_;
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
      }
   }
}
