package game.view.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.quest.QuestRewardPopupClip;
   import idv.cjcat.signals.Signal;
   
   public class RewardPopup extends ClipBasedPopup
   {
       
      
      private var reward:Vector.<InventoryItem>;
      
      protected var clip:QuestRewardPopupClip;
      
      private var _header:String;
      
      private var _label:String;
      
      private var _textOnButton:String;
      
      public const signal_buttonClick:Signal = new Signal();
      
      public function RewardPopup(param1:Vector.<InventoryItem>, param2:String = "reward")
      {
         _header = Translate.translate("UI_POPUP_QUEST_REWARD_HEADER");
         _label = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         _textOnButton = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         super(null);
         stashParams.windowName = param2;
         this.reward = param1;
      }
      
      public function set header(param1:String) : void
      {
         _header = param1;
      }
      
      public function set label(param1:String) : void
      {
         _label = param1;
      }
      
      public function set textOnButton(param1:String) : void
      {
         _textOnButton = param1;
      }
      
      public function get clipName() : String
      {
         return "popup_quest_reward";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,clipName) as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = _header;
         clip.tf_label_reward.text = _label;
         clip.button_ok.label = _textOnButton;
         clip.button_ok.signal_click.add(handler_okButtonClick);
         (clip.layout_item_list.layout as HorizontalLayout).paddingTop = !!_label?0:-25;
         clip.setReward(reward);
         AssetStorage.sound.dailyBonus.play();
      }
      
      private function handler_okButtonClick() : void
      {
         signal_buttonClick.dispatch();
         close();
      }
   }
}
