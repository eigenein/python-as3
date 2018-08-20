package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.utils.setTimeout;
   import game.assets.HeroRsxAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.chest.SoundGuiAnimation;
   import org.osflash.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class ExpeditionRewardPopupSceneClip extends GuiClipNestedContainer
   {
       
      
      private var heroPreview:HeroPreview;
      
      private var expedition:ExpeditionValueObject;
      
      public var skin_bg:ClipSprite;
      
      public var hero_position_after:GuiClipContainer;
      
      private var _signal_end:Signal;
      
      private var _signal_death_start:Signal;
      
      public function ExpeditionRewardPopupSceneClip()
      {
         skin_bg = new ClipSprite();
         hero_position_after = new GuiClipContainer();
         _signal_end = new Signal();
         _signal_death_start = new Signal();
         super();
      }
      
      public function get signal_end() : Signal
      {
         return _signal_end;
      }
      
      public function get signal_death_start() : Signal
      {
         return _signal_death_start;
      }
      
      public function start(param1:ExpeditionValueObject) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         this.expedition = param1;
         if(param1.storyDesc_unitId)
         {
            heroPreview = new HeroPreview();
            var _loc5_:* = param1.storyDesc_assetScale;
            heroPreview.graphics.scaleY = _loc5_;
            heroPreview.graphics.scaleX = _loc5_;
            hero_position_after.container.addChild(heroPreview.graphics);
            heroPreview.graphics.touchable = false;
            heroPreview.loadHero(DataStorage.hero.getUnitById(param1.storyDesc_unitId));
            _loc4_ = AssetStorage.hero.getById(param1.storyDesc_unitId);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc4_,handler_assetLoaded);
         }
         else if(param1.story.isValkyrie)
         {
            _loc2_ = AssetStorage.rsx.dialog_zeppelin.create(SoundGuiAnimation,"val_blessing_expedition_win");
            _loc3_ = 1000 * (_loc2_.lastFrame / 60);
            hero_position_after.container.addChild(_loc2_.graphics);
            setTimeout(handler_endAnimation,Math.max(100,_loc3_ - 100));
            setTimeout(_dispatchDeath,_loc3_ / 2);
         }
      }
      
      private function handler_assetLoaded(param1:HeroRsxAsset) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(expedition.story.isHero)
         {
            _loc2_ = 1000 * heroPreview.win();
            setTimeout(handler_endAnimation,Math.max(100,_loc2_ - 100));
            setTimeout(_dispatchDeath,_loc2_ / 2);
         }
         else
         {
            _loc3_ = AssetStorage.rsx.dialog_expedition.create(GuiAnimation,"creep_hit");
            _loc3_.playOnce();
            container.addChild(_loc3_.graphics);
            heroPreview.hit();
            setTimeout(_creepDie,600);
         }
      }
      
      private function _creepDie() : void
      {
         var _loc1_:int = 1000 * heroPreview.die(null);
         setTimeout(handler_endAnimation,Math.max(100,_loc1_ - 100));
         _dispatchDeath();
      }
      
      private function _dispatchEnd() : void
      {
         _signal_end.dispatch();
      }
      
      private function _dispatchDeath() : void
      {
         _signal_death_start.dispatch();
      }
      
      private function handler_endAnimation() : void
      {
         var _loc1_:Tween = new Tween(hero_position_after.graphics,0.5);
         _loc1_.animate("alpha",0);
         Starling.juggler.add(_loc1_);
         _dispatchEnd();
      }
   }
}
