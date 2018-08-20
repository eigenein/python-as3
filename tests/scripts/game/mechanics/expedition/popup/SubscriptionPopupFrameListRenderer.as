package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.expedition.model.SubscriptionLevelValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class SubscriptionPopupFrameListRenderer extends ListItemRenderer
   {
       
      
      private var clip:GuiClipNestedContainer;
      
      public function SubscriptionPopupFrameListRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_artifact_subscription.create(GuiClipNestedContainer,"subscription_level_frame_renderer");
         width = clip.graphics.width;
         addChild(clip.graphics);
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:SubscriptionLevelValueObject = data as SubscriptionLevelValueObject;
         if(!_loc1_)
         {
            return;
         }
         clip.graphics.visible = _loc1_.currentLevel == _loc1_.level.level;
      }
   }
}
