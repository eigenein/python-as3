package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.expedition.model.SubscriptionLevelValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class SubscriptionPopupListRenderer extends ListItemRenderer
   {
       
      
      private var clip:SubscriptionPopupListRendererClip;
      
      public function SubscriptionPopupListRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_artifact_subscription.create(SubscriptionPopupListRendererClip,"subscription_level_renderer");
         addChild(clip.graphics);
         width = clip.frame.graphics.width;
         height = clip.frame.graphics.height;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:SubscriptionLevelValueObject = data as SubscriptionLevelValueObject;
         if(!_loc1_)
         {
            return;
         }
         clip.reward_item.data = _loc1_.level.dailyReward.outputDisplay[0];
         clip.tf_label_daily.text = Translate.translate("UI_SUBSCRIPTION_LEVEL_RENDERER_TF_LABEL_DAILY");
         clip.tf_level.text = Translate.translateArgs("UI_SUBSCRIPTION_LEVEL_RENDERER_TF_LEVEL",_loc1_.level.level);
         clip.frame.graphics.visible = false;
         clip.arrow_after.graphics.visible = _loc1_.currentLevel != _loc1_.level.level && _loc1_.level.level != _loc1_.lastLevel && _loc1_.level.level != _loc1_.currentLevel - 1;
         clip.arrow_before.graphics.visible = false;
      }
   }
}
