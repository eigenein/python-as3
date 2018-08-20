package game.view.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipImage;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.mail.PlayerMailActionButton;
   import game.mediator.gui.popup.mail.PlayerMailButtonAction;
   import game.mediator.gui.popup.mail.PlayerMailEntryTranslation;
   import game.mediator.gui.popup.mail.PlayerMailEntryValueObject;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionFactory;
   import game.model.GameModel;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.gui.components.HeroPortrait;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.socialgrouppromotion.SocialGroupPromotionBlock;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMailEntryPopup extends ClipBasedPopup
   {
       
      
      private var buttonActions:Vector.<PlayerMailButtonAction>;
      
      private var actionButtons:Vector.<PlayerMailActionButton>;
      
      private var vo:PlayerMailEntryValueObject;
      
      private var clip:PlayerMailEntryPopupClip;
      
      private var _signal_farm:Signal;
      
      public function PlayerMailEntryPopup(param1:PlayerMailEntryValueObject)
      {
         super(null);
         this.vo = param1;
         _signal_farm = new Signal(PlayerMailEntryValueObject);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_timer);
      }
      
      override protected function initialize() : void
      {
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:* = null;
         var _loc13_:* = undefined;
         _loc12_ = 0;
         var _loc6_:int = 0;
         var _loc15_:* = null;
         _loc15_ = null;
         var _loc7_:* = null;
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_mail_entry();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         clip.title = Translate.translate("UI_DIALOG_MAIL_TITLE");
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_MAIL_ENTRY_REWARD");
         clip.tf_body.text = vo.title + "\n\n" + vo.text;
         clip.button_farm_all.signal_click.add(handler_farm);
         if(vo.hasTimeLimit && vo.farmIsAvailable)
         {
            GameTimer.instance.oneSecTimer.add(handler_timer);
            handler_timer();
         }
         buttonActions = PlayerMailEntryTranslation.getButtonActions(vo.mail);
         actionButtons = new Vector.<PlayerMailActionButton>();
         if(buttonActions.length > 1)
         {
            _loc12_ = buttonActions.length;
            _loc5_ = 1;
            while(_loc5_ < _loc12_)
            {
               _loc9_ = AssetStorage.rsx.popup_theme.create(PlayerMailActionButton,"boring_buttonClip_140");
               _loc9_.signal_click.add(handler_mailActionButton);
               _loc9_.data = buttonActions[_loc5_];
               clip.layout_buttons.addChild(_loc9_.graphics);
               actionButtons.push(_loc9_);
               _loc5_++;
            }
         }
         updateButtonLabel();
         if(vo.reward)
         {
            _loc13_ = vo.reward.outputDisplay;
         }
         else
         {
            if(clip.tf_available != null)
            {
               clip.tf_available.visible = false;
            }
            clip.tf_label_reward.visible = false;
         }
         _loc12_ = clip.reward_tiles.length;
         _loc6_ = 0;
         while(_loc6_ < _loc12_)
         {
            if(_loc13_ && _loc13_.length > _loc6_)
            {
               clip.reward_tiles[_loc6_].setData(_loc13_[_loc6_]);
            }
            else
            {
               clip.reward_tiles[_loc6_].graphics.visible = false;
            }
            _loc6_++;
         }
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc8_:GameScrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (_loc8_.layout as VerticalLayout).horizontalAlign = "center";
         (_loc8_.layout as VerticalLayout).gap = 35;
         _loc8_.width = clip.list_container.graphics.width;
         _loc8_.height = clip.list_container.graphics.height;
         clip.list_container.addChild(_loc8_);
         _loc8_.addChild(clip.tf_body);
         if(vo.mail.type == "top")
         {
            _loc15_ = SocialGroupPromotionFactory.arenaReward();
            if(_loc15_)
            {
               _loc15_.initialize(stashParams);
               _loc8_.addChild(_loc15_.graphics);
            }
         }
         if(Translate.has("LIB_SOCIAL_GROUP_PROMO_WELCOMEGIFT"))
         {
            if(vo.mail.type == "registrationGift" || vo.mail.type == "mass" || vo.mail.type == "admin")
            {
               _loc15_ = SocialGroupPromotionFactory.welcomeGift();
               if(_loc15_)
               {
                  _loc15_.initialize(stashParams);
                  _loc8_.addChild(_loc15_.graphics);
               }
            }
         }
         if(vo.mail.type == "promoteGift")
         {
            _loc7_ = GameModel.instance.player.heroes.getById(vo.mail.params.hero);
            _loc11_ = new HeroPortrait();
            _loc14_ = new HeroEntrySourceData({
               "level":_loc7_.level,
               "star":_loc7_.star.star.id,
               "color":vo.mail.params.fromColor,
               "slots":[0,0,0,0,0,0,0]
            });
            _loc11_.data = new HeroEntryValueObject(_loc7_.hero,new HeroEntry(_loc7_.hero,_loc14_));
            _loc10_ = new HeroPortrait();
            _loc4_ = new HeroEntrySourceData({
               "level":_loc7_.level,
               "star":_loc7_.star.star.id,
               "color":vo.mail.params.toColor,
               "slots":[0,0,0,0,0,0,0]
            });
            _loc10_.data = new HeroEntryValueObject(_loc7_.hero,new HeroEntry(_loc7_.hero,_loc4_));
            _loc3_ = AssetStorage.rsx.popup_theme.create(GuiClipImage,"ArrowMed");
            _loc2_ = new LayoutGroup();
            _loc2_.layout = new HorizontalLayout();
            (_loc2_.layout as HorizontalLayout).gap = 20;
            (_loc2_.layout as HorizontalLayout).verticalAlign = "middle";
            _loc2_.addChild(_loc11_);
            _loc2_.addChild(_loc3_.graphics);
            _loc2_.addChild(_loc10_);
            _loc8_.addChild(_loc2_);
            (_loc8_.layout as VerticalLayout).gap = 15;
         }
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
      }
      
      public function get signal_farm() : Signal
      {
         return _signal_farm;
      }
      
      private function updateButtonLabel() : void
      {
         if(buttonActions && buttonActions.length)
         {
            clip.button_farm_all.label = buttonActions[0].label;
         }
         else if(vo.reward && vo.farmIsAvailable)
         {
            clip.button_farm_all.label = Translate.translate("UI_DIALOG_MAIL_ENTRY_FARM");
         }
         else
         {
            clip.button_farm_all.label = Translate.translate("UI_DIALOG_MAIL_ENTRY_OK");
         }
      }
      
      private function handler_mailActionButton(param1:PlayerMailButtonAction) : void
      {
         param1.callAction();
      }
      
      private function handler_farm() : void
      {
         _signal_farm.dispatch(vo);
         close();
      }
      
      private function handler_timer() : void
      {
         var _loc1_:Boolean = false;
         if(!vo.farmIsAvailable)
         {
            updateButtonLabel();
            GameTimer.instance.oneSecTimer.remove(handler_timer);
            _loc1_ = vo.farmIsAvailable;
            if(clip.tf_available)
            {
               clip.tf_available.alpha = !!_loc1_?0.65:1;
               clip.tf_available.text = String(vo.timeLeftString);
            }
            if(vo.reward)
            {
               if(_loc1_)
               {
                  if(clip.layout_reward.filter != null)
                  {
                     clip.layout_reward.filter.dispose();
                     clip.layout_reward.filter = null;
                  }
               }
               else
               {
                  clip.layout_reward.alpha = 0.3;
                  if(clip.layout_reward.filter == null)
                  {
                     clip.layout_reward.filter = AssetStorage.rsx.popup_theme.filter_disabled;
                  }
               }
            }
         }
      }
   }
}
