package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.boss.mediator.BossRecommendedHeroValueObject;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.hero.MiniHeroPortraitClipWithCheck;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.Image;
   
   public class BossFrameExtRenderer extends GuiClipNestedContainer
   {
       
      
      private var data:BossTypeDescription;
      
      private var recommendedTooltip:TooltipVO;
      
      public var tf_desc:ClipLabel;
      
      public var tf_heroes:ClipLabel;
      
      public var coin_image:GuiClipImage;
      
      public var container_boss_icon:ClipLayout;
      
      public var roundSelector_inst0:ClipSprite;
      
      public var button_recommended:ClipButton;
      
      public var hero:Vector.<MiniHeroPortraitClipWithCheck>;
      
      public var layout_recommended:ClipLayout;
      
      public var mediator:BossFrameRendererMediator;
      
      public function BossFrameExtRenderer()
      {
         recommendedTooltip = new TooltipVO(TooltipTextView,null);
         tf_desc = new ClipLabel();
         tf_heroes = new ClipLabel();
         coin_image = new GuiClipImage();
         container_boss_icon = ClipLayout.none();
         roundSelector_inst0 = new ClipSprite();
         button_recommended = new ClipButton();
         layout_recommended = ClipLayout.horizontalMiddleCentered(1);
         super();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         TooltipHelper.removeTooltip(coin_image.graphics);
         TooltipHelper.removeTooltip(button_recommended.graphics);
         _loc1_ = 0;
         while(_loc1_ < hero.length)
         {
            hero[_loc1_].signal_click.remove(handler_heroClick);
            hero[_loc1_].dispose();
            _loc1_++;
         }
      }
      
      public function setData(param1:BossTypeDescription) : void
      {
         this.data = param1;
         tf_desc.text = param1.description;
         coin_image.image.texture = mediator.getBossCoinIcon(param1);
         TooltipHelper.removeTooltip(coin_image.graphics);
         var _loc3_:TooltipVO = new TooltipVO(TooltipTextView,null);
         _loc3_.hintData = Translate.fastTranslate("UI_DIALOG_BOSS_COIN_TOOLTIP",[mediator.getBossCoinName(param1)]);
         TooltipHelper.addTooltip(coin_image.graphics,_loc3_);
         var _loc2_:Image = new Image(mediator.getBossIcon(param1));
         _loc2_.scaleX = -1;
         _loc2_.x = _loc2_.width;
         container_boss_icon.removeChildren();
         container_boss_icon.addChild(_loc2_);
         updateRecommendedHeroes(mediator.getRecommendedHeroes(param1));
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_heroes.text = Translate.translate("UI_DIALOG_BOSS_RECOMMENDED_HEROES");
         recommendedTooltip.hintData = Translate.translate("UI_DIALOG_BOSS_RECOMMENDED_TOOLTIP");
         TooltipHelper.addTooltip(button_recommended.graphics,recommendedTooltip);
         var _loc4_:int = 0;
         var _loc3_:* = hero;
         for each(var _loc2_ in hero)
         {
            layout_recommended.addChild(_loc2_.graphics);
            _loc2_.signal_click.add(handler_heroClick);
         }
         button_recommended.signal_click.add(handler_buttonRecommendedClick);
      }
      
      private function handler_buttonRecommendedClick() : void
      {
         mediator.action_recommended(data);
      }
      
      private function updateRecommendedHeroes(param1:Vector.<BossRecommendedHeroValueObject>) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Boolean = false;
         if(!param1)
         {
            return;
         }
         var _loc6_:int = Math.min(param1.length,hero.length);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = param1[_loc5_];
            _loc2_ = hero[_loc5_];
            _loc4_ = _loc3_.owned;
            _loc2_.data = _loc3_;
            _loc2_.graphics.alpha = !!_loc4_?1:0.7;
            _loc2_.checked = _loc4_;
            _loc5_++;
         }
      }
      
      private function handler_heroClick(param1:UnitEntryValueObject) : void
      {
         if(param1 is HeroEntryValueObject)
         {
            mediator.action_hero(param1 as HeroEntryValueObject);
         }
      }
   }
}
