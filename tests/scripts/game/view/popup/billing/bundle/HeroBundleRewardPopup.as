package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroBundleRewardPopup extends ClipBasedPopup
   {
       
      
      private var desc:HeroBundleRewardPopupDescription;
      
      private var clip:HeroBundleRewardPopupClip;
      
      public function HeroBundleRewardPopup(param1:HeroBundleRewardPopupDescription)
      {
         super(null);
         this.desc = param1;
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         super.dispose();
         if(clip)
         {
            _loc2_ = clip.reward_item.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = clip.reward_item[_loc3_];
               _loc1_.dispose();
               _loc3_++;
            }
            clip = null;
         }
      }
      
      override protected function initialize() : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         super.initialize();
         var _loc1_:Vector.<InventoryItem> = desc.getSortedReward();
         if(_loc1_.length > 6)
         {
            clip = AssetStorage.rsx.popup_theme.create(HeroBundleRewardPopupClip,"dialog_bundle_reward_8");
         }
         else if(_loc1_.length > 4)
         {
            clip = AssetStorage.rsx.popup_theme.create(HeroBundleRewardPopupClip,"dialog_bundle_reward_6");
         }
         else if(desc.description)
         {
            clip = AssetStorage.rsx.popup_theme.create(HeroBundleRewardPopupClip,"dialog_bundle_reward_4");
         }
         else
         {
            clip = AssetStorage.rsx.popup_theme.create(HeroBundleRewardPopupClip,"dialog_bundle_reward_4_no_description");
         }
         addChild(clip.graphics);
         clip.tf_header.text = desc.title;
         clip.tf_label_desc.text = desc.description;
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_CAPTION");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_ok.initialize(desc.buttonLabel,handler_buttonClick);
         var _loc3_:int = Math.min(_loc1_.length,clip.reward_item.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = clip.reward_item[_loc4_];
            _loc2_.setData(_loc1_[_loc4_]);
            _loc4_++;
         }
         _loc4_ = _loc3_;
         while(_loc4_ < clip.reward_item.length)
         {
            _loc2_ = clip.reward_item[_loc4_];
            _loc2_.graphics.visible = false;
            _loc4_++;
         }
      }
      
      private function handler_buttonClick() : void
      {
         desc.signal_close.dispatch();
         close();
      }
   }
}
