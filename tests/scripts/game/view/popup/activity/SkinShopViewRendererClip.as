package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.billing.specialoffer.TripleSkinBundleValueObject;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SkinShopViewRendererClip extends GuiClipNestedContainer
   {
       
      
      private var mediator:SkinShopMediator;
      
      private var vo:TripleSkinBundleValueObject;
      
      private var heroPreview:HeroPreview;
      
      public var button_no_hero:ClipButtonLabeled;
      
      public var tf_label_no_hero:ClipLabel;
      
      public var layout_no_hero:ClipLayout;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var tf_discount:ClipLabel;
      
      public var hero_position:GuiClipContainer;
      
      public var reward_item:Vector.<InventoryItemRenderer>;
      
      public var tf_label_stat_bonus:SpecialClipLabel;
      
      public var layout_statBonus:ClipLayout;
      
      public var button_to_store:ClipButtonLabeledAnimated;
      
      public var xGraphic:ClipSprite;
      
      public var tf_skin_owned:ClipLabel;
      
      public var layout_skin_owned:ClipLayout;
      
      public var tf_label_skin_name:ClipLabel;
      
      public var layout_skin_name:ClipLayout;
      
      public function SkinShopViewRendererClip()
      {
         button_no_hero = new ClipButtonLabeled();
         tf_label_no_hero = new ClipLabel(true);
         layout_no_hero = ClipLayout.horizontalMiddleCentered(4,tf_label_no_hero,button_no_hero);
         tf_label_reward = new ClipLabel();
         tf_old_price = new ClipLabel();
         tf_discount = new ClipLabel();
         hero_position = new GuiClipContainer();
         reward_item = new Vector.<InventoryItemRenderer>();
         tf_label_stat_bonus = new SpecialClipLabel();
         layout_statBonus = ClipLayout.horizontalMiddleCentered(4,tf_label_stat_bonus);
         button_to_store = new ClipButtonLabeledAnimated();
         xGraphic = new ClipSprite();
         tf_skin_owned = new ClipLabel(true);
         layout_skin_owned = ClipLayout.horizontalMiddleCentered(4,tf_skin_owned);
         tf_label_skin_name = new ClipLabel();
         layout_skin_name = ClipLayout.verticalCenter(12,tf_label_skin_name,layout_no_hero);
         super();
      }
      
      public function setData(param1:TripleSkinBundleValueObject, param2:SkinShopMediator) : void
      {
         var _loc5_:int = 0;
         this.vo = param1;
         this.mediator = param2;
         var _loc3_:int = param1.reward.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(param1.reward.length > _loc5_)
            {
               reward_item[_loc5_].setData(param1.reward[_loc5_]);
            }
            _loc5_++;
         }
         var _loc4_:String = "";
         if(param1.hero.id == 25)
         {
            _loc4_ = "AMPLIFIED_";
         }
         heroPreview.loadHero(param1.hero,param1.skinId,_loc4_);
         button_to_store.signal_click.add(handler_buy);
         button_no_hero.signal_click.add(handler_no_hero_info);
         tf_old_price.text = param1.oldPrice;
         button_to_store.label = param1.costStrng;
         tf_skin_owned.text = Translate.translate("UI_TRIPLE_SKI_BUNDLE_RENDERER_TF_SKIN_OWNED");
         tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",param1.discountValue);
         tf_label_stat_bonus.text = param1.statBonus;
         tf_label_skin_name.text = param1.skinName;
         updatePlayerSkinState(true);
         param1.playerOwnsHero.signal_update.add(updatePlayerSkinState);
         param1.playerOwnsSkin.signal_update.add(updatePlayerSkinState);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_no_hero.label = "?";
         tf_label_no_hero.text = Translate.translate("UI_DIALOG_BOSS_NO_HERO");
         tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         heroPreview = new HeroPreview();
         var _loc2_:* = 1.35;
         heroPreview.graphics.scaleY = _loc2_;
         heroPreview.graphics.scaleX = _loc2_;
         hero_position.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
      }
      
      private function updatePlayerSkinState(param1:Boolean) : void
      {
         var _loc2_:* = !vo.playerOwnsSkin.value;
         button_to_store.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         tf_old_price.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         xGraphic.graphics.visible = _loc2_;
         tf_discount.graphics.visible = _loc2_;
         layout_skin_owned.graphics.visible = vo.playerOwnsSkin.value;
         layout_no_hero.graphics.visible = !vo.playerOwnsHero.value;
      }
      
      private function handler_buy() : void
      {
         mediator.action_buy(vo);
      }
      
      private function handler_no_hero_info() : void
      {
         mediator.action_no_hero_info(vo);
      }
   }
}
