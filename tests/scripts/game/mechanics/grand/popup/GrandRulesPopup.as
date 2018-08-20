package game.mechanics.grand.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaRewardDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.arena.ArenaRulesPopupValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.arena.rules.ArenaRulesPlaceRewardClip;
   import game.view.popup.arena.rules.ArenaRulesPopupClip;
   import game.view.popup.arena.rules.ArenaRulesRewardItem;
   
   public class GrandRulesPopup extends ClipBasedPopup
   {
       
      
      private var clip:ArenaRulesPopupClip;
      
      private var vo:ArenaRulesPopupValueObject;
      
      private var renderers:Vector.<ArenaRulesPlaceRewardClip>;
      
      public function GrandRulesPopup(param1:ArenaRulesPopupValueObject)
      {
         renderers = new Vector.<ArenaRulesPlaceRewardClip>();
         super(null);
         this.vo = param1;
      }
      
      override public function close() : void
      {
         var _loc2_:int = 0;
         super.close();
         var _loc1_:int = renderers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            renderers[_loc2_].dispose();
            _loc2_++;
         }
         clip.scroll_content.reward_block.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_arena_rules();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc3_:GameScrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (_loc3_.layout as VerticalLayout).horizontalAlign = "center";
         (_loc3_.layout as VerticalLayout).gap = 8;
         _loc3_.width = clip.list_container.graphics.width;
         _loc3_.height = clip.list_container.graphics.height;
         clip.list_container.addChild(_loc3_);
         clip.scroll_content.tf_label_place.text = Translate.translate("UI_POPUP_ARENA_RULES_PLACE_LABEL");
         clip.scroll_content.place_block.tf_place.text = vo.grandPlace;
         clip.scroll_content.tf_label_reward.text = vo.getGrandRewardLabel();
         clip.scroll_content.tf_reward_list_caption.text = Translate.translate("UI_POPUP_ARENA_REWARD_LIST_CAPTION");
         clip.scroll_content.tf_rules.text = Translate.translateArgs("UI_DIALOG_GRAND_ARENA_RULES",10);
         clip.scroll_content.tf_rules.maxHeight = Infinity;
         clip.scroll_content.tf_rules.height = NaN;
         clip.scroll_content.layout.height = NaN;
         var _loc4_:Vector.<InventoryItem> = vo.myReward;
         var _loc5_:int = clip.scroll_content.reward_block.reward_items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            if(_loc4_.length > _loc2_)
            {
               clip.scroll_content.reward_block.reward_items[_loc2_].data = _loc4_[_loc2_];
            }
            else
            {
               clip.scroll_content.reward_block.reward_items[_loc2_].data = null;
            }
            _loc2_++;
         }
         _loc3_.addChild(clip.scroll_content.layout);
         setupRewards(_loc3_);
      }
      
      protected function setupRewards(param1:GameScrollContainer) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = vo.rewardsByPlace.length;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc3_:* = vo.rewardsByPlace[0];
         var _loc6_:* = vo.rewardsByPlace[0];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = vo.rewardsByPlace[_loc4_];
            if(_loc3_.grandHourlyReward != _loc5_.grandHourlyReward)
            {
               createRewardEntryClip(param1,_loc3_,_loc6_);
               _loc3_ = _loc5_;
            }
            _loc6_ = _loc5_;
            _loc4_++;
         }
         if(_loc3_)
         {
            createRewardEntryClip(param1,_loc3_,_loc6_);
         }
      }
      
      protected function createRewardEntryClip(param1:GameScrollContainer, param2:ArenaRewardDescription, param3:ArenaRewardDescription) : void
      {
         var _loc6_:InventoryItemDescription = DataStorage.coin.getByIdent("grand_arena");
         var _loc4_:InventoryItem = new InventoryItem(_loc6_,param2.grandHourlyReward);
         var _loc5_:ArenaRulesPlaceRewardClip = AssetStorage.rsx.popup_theme.create_grand_arena_rules();
         setupRewardEntryClip(_loc5_,param2.placeFrom,param3.placeTo,_loc4_);
         renderers.push(_loc5_);
         param1.addChild(_loc5_.graphics);
      }
      
      protected function setupRewardEntryClip(param1:ArenaRulesPlaceRewardClip, param2:int, param3:int, param4:InventoryItem) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function setupRewardItem(param1:ArenaRulesRewardItem, param2:InventoryItem) : void
      {
         param1.icon_image.image.texture = AssetStorageUtil.getItemTexture(param2);
         param1.tf_amount.text = Translate.translateArgs("UI_DIALOG_GRAND_PLACEMENT_REWARD",param2.amount);
         param1.tf_amount.validate();
         TooltipHelper.addTooltip(param1.graphics,new TooltipVO(InventoryItemInfoTooltip,param2));
      }
   }
}
