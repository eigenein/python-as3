package game.battle.view
{
   import battle.Hero;
   import engine.core.animation.ZSortedSprite;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.INeedNestedParsing;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.entities.BattleHero;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipTiledImage;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class BattleBossHpBar extends GuiClipContainer implements IAnimatable, INeedNestedParsing
   {
       
      
      private var hero:BattleHero;
      
      private var maxWidth:int = 600;
      
      private var clipRect:Rectangle;
      
      private var alphaPhase:Number = 0;
      
      private var glowAlpha:Number = 0;
      
      private var hp:Number = NaN;
      
      private var hpSmooth:Number = NaN;
      
      private var hpChanged:Number = 0;
      
      public var label:ClipLabel;
      
      public var icon:ClipSprite;
      
      public var icon_container:ClipLayoutNone;
      
      public var frame:GuiClipScale3Image;
      
      public var fill:GuiAnimation;
      
      public var glow:ClipSprite;
      
      public var bg_tiled:ClipTiledImage;
      
      public function BattleBossHpBar(param1:BattleHero)
      {
         super();
         AssetStorage.rsx.battle_interface.initGuiClip(this,"boss_hpBar");
         var _loc4_:UnitDescription = DataStorage.hero.getHeroById(param1.hero.desc.heroId);
         label.text = _loc4_.name;
         clipRect = new Rectangle(0,0,469,21);
         (fill.graphics as ZSortedSprite).clipRect = clipRect;
         maxWidth = clipRect.width;
         var _loc2_:Number = icon_container.width * 0.5;
         icon_container.filter = new RoundMaskFilter(_loc2_,_loc2_,_loc2_);
         var _loc3_:Image = new Image(AssetStorage.inventory.getUnitSquareTexture(_loc4_));
         icon_container.addChild(_loc3_);
         this.hero = param1;
         Starling.juggler.add(this);
         param1.hero.onRemove.add(handler_remove);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc5_:* = NaN;
         alphaPhase = alphaPhase + param1 * 2;
         var _loc3_:ZSortedSprite = fill.graphics as ZSortedSprite;
         var _loc4_:Number = hero.hero.getRelativeHealth();
         if(this.hp != _loc4_)
         {
            if(this.hp == this.hp)
            {
               hpChanged = 1.2;
            }
            this.hp = _loc4_;
         }
         clipRect.width = clipRect.width * 0.9 + 0.1 * maxWidth * _loc4_;
         (fill.graphics as ZSortedSprite).clipRect = clipRect;
         if(_loc4_ < 1)
         {
            _loc5_ = 0.4;
            glow.graphics.x = _loc3_.x + _loc3_.width;
         }
         else
         {
            _loc5_ = 1;
         }
         var _loc2_:Number = Math.abs(Math.cos(alphaPhase));
         glow.graphics.alpha = (1 - _loc5_) * (1 - 0.4 * _loc2_) + _loc5_ * hpChanged;
         hpChanged = hpChanged * 0.95;
      }
      
      private function handler_remove(param1:Hero) : void
      {
         Starling.juggler.remove(this);
         graphics.removeFromParent(true);
      }
   }
}
