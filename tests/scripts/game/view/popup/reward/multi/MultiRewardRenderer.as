package game.view.popup.reward.multi
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.component.RewardValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class MultiRewardRenderer extends ListItemRenderer
   {
       
      
      protected var clip:MultiRewardRendererClip;
      
      public function MultiRewardRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createClip();
      }
      
      override protected function commitData() : void
      {
         if(_data is RewardValueObject)
         {
            setCaption(_data as RewardValueObject);
         }
      }
      
      protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create_renderer_multi_reward();
         addChild(clip.graphics);
      }
      
      protected function setCaption(param1:RewardValueObject) : void
      {
         clip.layout_item_list.list.dataProvider = new ListCollection(param1.itemReward.outputDisplay);
         clip.tf_empty.visible = param1.itemReward.isEmpty;
         if(clip.tf_empty.visible)
         {
            clip.tf_empty.text = Translate.translate("UI_POPUP_MULTI_REWARD_EMPTY");
         }
      }
   }
}
