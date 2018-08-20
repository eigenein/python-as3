package game.battle.gui.hero
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import flash.utils.getTimer;
   import game.battle.gui.BattleGUIProgressbarBlock;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class BattleGUIHeroPortrait extends ClipAnimatedContainer
   {
      
      public static var USE_DISTINCTIVE_HERO_ULT_STATES:Boolean = false;
      
      private static const REPEAT_ACTIVATION_ANIMATION_DELAY_MS:Number = 500;
       
      
      private var lastTimeUltActivated:Number = 0;
      
      public var progressbar_block_inst0:BattleGUIProgressbarBlock;
      
      public var hero_portrait_bg_container:GuiClipLayoutContainer;
      
      public var backGlow:ClipSprite;
      
      public var portrait:BattleGuiHeroPortraitButton;
      
      public var ult_activate:GuiAnimation;
      
      public var ult_active:GuiAnimation;
      
      public var ult_full:GuiAnimation;
      
      public var ult_deactivate:GuiAnimation;
      
      public function BattleGUIHeroPortrait()
      {
         ult_activate = new GuiAnimation();
         ult_active = new GuiAnimation();
         ult_full = new GuiAnimation();
         ult_deactivate = new GuiAnimation();
         super();
      }
      
      public function setState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         portrait.isEnabled = param1;
         if(param2)
         {
            _loc4_ = getTimer();
            if(_loc4_ - lastTimeUltActivated > 500)
            {
               ult_activate.show(container);
               ult_activate.playOnceAndHide();
               lastTimeUltActivated = _loc4_;
            }
            _loc5_ = ult_active.graphics.parent;
            if(_loc5_ && ult_full.currentFrame)
            {
               ult_full.currentFrame = ult_active.currentFrame;
            }
            ult_active.show(container);
            ult_active.playLoop();
            ult_full.hide();
         }
         else if(param3)
         {
            _loc5_ = ult_full.graphics.parent;
            if(USE_DISTINCTIVE_HERO_ULT_STATES)
            {
               container.addChildAt(ult_full.graphics,0);
            }
            else
            {
               ult_full.show(container);
               ult_full.graphics.alpha = 0.3;
            }
            ult_full.playLoop();
            ult_full.playbackSpeed = 0.35;
            if(_loc5_ && ult_active.graphics.parent)
            {
               ult_full.currentFrame = ult_active.currentFrame;
            }
            ult_active.hide();
         }
         else
         {
            ult_activate.hide();
            ult_active.hide();
            ult_full.hide();
         }
      }
   }
}
