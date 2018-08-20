package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.tower.TowerRewardDescription;
   import game.mediator.gui.popup.tower.TowerRulesPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.arena.rules.ArenaRulesPlaceRewardClip;
   
   public class TowerRulesPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TowerRulesPopupMediator;
      
      private var clip:TowerRulesPopupClip;
      
      private var renderers:Vector.<ArenaRulesPlaceRewardClip>;
      
      public function TowerRulesPopup(param1:TowerRulesPopupMediator)
      {
         renderers = new Vector.<ArenaRulesPlaceRewardClip>();
         super(param1);
         this.mediator = param1;
      }
      
      override public function close() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = renderers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            renderers[_loc2_].dispose();
            _loc2_++;
         }
         clip.scroll_content.reward_block.dispose();
         super.close();
      }
      
      override protected function initialize() : void
      {
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc7_:* = null;
         _loc8_ = undefined;
         _loc9_ = 0;
         _loc5_ = 0;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(TowerRulesPopupClip,"dialog_tower_rules");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc6_:GameScrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (_loc6_.layout as VerticalLayout).horizontalAlign = "center";
         (_loc6_.layout as VerticalLayout).gap = 8;
         _loc6_.width = clip.list_container.graphics.width;
         _loc6_.height = clip.list_container.graphics.height;
         clip.list_container.addChild(_loc6_);
         clip.scroll_content.tf_label_place.text = Translate.translate("UI_POPUP_TOWER_RULES_POINTS_LABEL");
         clip.scroll_content.place_block.tf_place.text = mediator.myPoints.toString();
         clip.scroll_content.tf_label_reward.text = Translate.translate("UI_POPUP_TOWER_LABEL_REWARD");
         clip.scroll_content.tf_reward_list_caption.text = Translate.translate("UI_POPUP_TOWER_REWARD_LIST_CAPTION");
         clip.scroll_content.tf_rules.text = Translate.translate("UI_POPUP_TOWER_RULES_LIST");
         clip.scroll_content.tf_rules.maxHeight = Infinity;
         clip.scroll_content.tf_rules.height = NaN;
         clip.scroll_content.layout.height = NaN;
         if(mediator.myReward)
         {
            _loc8_ = mediator.myReward;
            _loc9_ = clip.scroll_content.reward_block.reward_items.length;
            _loc5_ = 0;
            while(_loc5_ < _loc9_)
            {
               if(_loc8_.length > _loc5_)
               {
                  clip.scroll_content.reward_block.reward_items[_loc5_].data = _loc8_[_loc5_];
               }
               else
               {
                  clip.scroll_content.reward_block.reward_items[_loc5_].data = null;
               }
               _loc5_++;
            }
         }
         else
         {
            clip.scroll_content.reward_block.graphics.visible = false;
            clip.scroll_content.tf_label_reward.visible = false;
         }
         _loc6_.addChild(clip.scroll_content.layout);
         renderers = new Vector.<ArenaRulesPlaceRewardClip>();
         var _loc3_:int = mediator.rewardsByPlace.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = AssetStorage.rsx.popup_theme.create_renderer_arena_rules();
            _loc6_.addChild(_loc2_.graphics);
            _loc7_ = mediator.rewardsByPlace[_loc4_];
            _loc2_.tf_place.text = Translate.translateArgs("UI_POPUP_TOWER_RULES_PLACE",_loc7_.pointsEarned);
            _loc2_.tf_place.validate();
            _loc8_ = _loc7_.reward.outputDisplay;
            _loc9_ = _loc2_.reward_items.length;
            _loc5_ = 0;
            while(_loc5_ < _loc9_)
            {
               if(_loc8_.length > _loc5_)
               {
                  _loc2_.reward_items[_loc5_].data = _loc8_[_loc5_];
               }
               else
               {
                  _loc2_.reward_items[_loc5_].data = null;
               }
               _loc5_++;
            }
            renderers.push(_loc2_);
            _loc4_++;
         }
      }
   }
}
