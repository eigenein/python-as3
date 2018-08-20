package game.view.popup.mission
{
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.mission.MissionEnterPopupMediator;
   import game.view.popup.reward.MissionEnterPopupRewardItemRenderer;
   
   public class MissionEnterPopupDropList extends List
   {
       
      
      private var mediator:MissionEnterPopupMediator;
      
      public function MissionEnterPopupDropList(param1:MissionEnterPopupMediator)
      {
         super();
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 5;
         _loc1_.useVirtualLayout = false;
         _loc1_.verticalAlign = "middle";
         itemRendererType = MissionEnterPopupRewardItemRenderer;
         layout = _loc1_;
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
      }
   }
}
