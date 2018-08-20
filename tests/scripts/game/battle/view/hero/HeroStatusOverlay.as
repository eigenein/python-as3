package game.battle.view.hero
{
   import engine.core.animation.ZSortedSprite;
   import engine.core.utils.VectorUtil;
   import feathers.controls.Label;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.entities.BattleEffect;
   import game.battle.controller.hero.BattleHeroInspector;
   import game.battle.gui.BattleHpBarClip;
   import game.battle.gui.BattleSpeechBubble;
   import game.view.gui.components.GameLabel;
   
   public class HeroStatusOverlay
   {
      
      public static const BAR_VISIBILITY_DURATION:Number = 2;
      
      public static const BAR_HIDING_DURATION:Number = 0.3;
      
      public static const BAR_POSITION_START_Y:Number = -195;
      
      public static const BAR_POSITION_DELTA_Y:Number = 13;
       
      
      public const graphics:ZSortedSprite = new ZSortedSprite();
      
      protected var effectsLabel:Label;
      
      protected var hpBar:BattleHpBarClip;
      
      protected var hpBarVisibility:Number;
      
      protected var hpBarStyleRed:Boolean;
      
      protected var _headYOffset:Number;
      
      protected var _battleInspector:BattleHeroInspector;
      
      protected var effectsBar:BattleHeroEffectStatusBar;
      
      protected var speechBubble:BattleSpeechBubble;
      
      protected var bars:Vector.<BattleHpBarClip>;
      
      public function HeroStatusOverlay()
      {
         bars = new Vector.<BattleHpBarClip>();
         super();
         effectsLabel = GameLabel.size16();
         effectsLabel.y = 10;
         effectsLabel.x = -40;
         graphics.addChild(effectsLabel);
      }
      
      public function set headYOffset(param1:Number) : void
      {
         this._headYOffset = param1;
         if(speechBubble)
         {
            speechBubble.graphics.y = _headYOffset;
         }
      }
      
      public function set battleInspector(param1:BattleHeroInspector) : void
      {
         _battleInspector = param1;
         graphics.addChild(_battleInspector.graphics);
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(hpBarVisibility > 0)
         {
            hpBarVisibility = hpBarVisibility - param1;
            if(hpBarVisibility <= 0)
            {
               hpBarVisibility = 0;
               hpBar.visible = false;
            }
            else
            {
               hpBar.alpha = hpBarVisibility > 0.3?1:Number(Math.sqrt(hpBarVisibility) / 0.3);
               hpBar.advanceTime(param1);
               hpBar.visible = true;
            }
         }
         if(speechBubble)
         {
            speechBubble.advanceTime(param1);
         }
         if(effectsBar)
         {
            effectsBar.advanceTime(param1);
         }
         var _loc4_:int = 0;
         var _loc3_:* = bars;
         for each(var _loc2_ in bars)
         {
            _loc2_.advanceTime(param1);
         }
         if(_battleInspector)
         {
            _battleInspector.advanceTime(param1);
         }
      }
      
      public function hide() : void
      {
         if(hpBar && hpBarVisibility > 0.3)
         {
            hpBarVisibility = 0.3;
         }
         if(_battleInspector)
         {
            graphics.removeChild(_battleInspector.graphics);
         }
      }
      
      public function cleanUpBattle() : void
      {
         if(effectsBar)
         {
            effectsBar.cleanUpBattle();
         }
      }
      
      public function fadeAway() : void
      {
         if(effectsBar)
         {
            effectsBar.fadeAway();
         }
      }
      
      public function setHpValue(param1:Number, param2:Number) : void
      {
         if(hpBar)
         {
            hpBar.setValue(param1,param2);
            hpBarVisibility = 2;
         }
      }
      
      public function defineHpValue(param1:Number, param2:Number) : void
      {
         if(hpBar)
         {
            hpBar.defineValue(param1,param2);
         }
      }
      
      public function addSpeechText(param1:String) : void
      {
         if(!speechBubble)
         {
            if(hpBarStyleRed)
            {
               speechBubble = AssetStorage.rsx.battle_interface.create_speechBubbleRed();
            }
            else
            {
               speechBubble = AssetStorage.rsx.battle_interface.create_speechBubbleGreen();
            }
            speechBubble.graphics.y = _headYOffset;
         }
         if(!speechBubble.graphics.parent)
         {
            graphics.addChild(speechBubble.graphics);
         }
         speechBubble.text = param1;
      }
      
      public function setText(param1:String) : void
      {
         effectsLabel.text = param1;
      }
      
      public function setRedBar() : void
      {
         if(hpBar && hpBarStyleRed)
         {
            return;
         }
         if(hpBar)
         {
            disposeHpBar();
         }
         createHpBarStyle(true);
      }
      
      public function setGreenBar() : void
      {
         if(hpBar && !hpBarStyleRed)
         {
            return;
         }
         if(hpBar)
         {
            disposeHpBar();
         }
         createHpBarStyle(false);
      }
      
      public function addBar(param1:BattleHpBarClip) : void
      {
         if(bars.indexOf(param1) == -1)
         {
            bars.push(param1);
            graphics.addChild(param1);
            positionBar(param1,bars.length - 1);
         }
      }
      
      public function removeBar(param1:BattleHpBarClip) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = bars.indexOf(param1);
         if(_loc3_ != -1)
         {
            graphics.removeChild(param1);
            VectorUtil.removeAt(bars,_loc3_);
            _loc2_ = bars.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               positionBar(bars[_loc4_],_loc4_);
               _loc4_++;
            }
         }
      }
      
      public function addEffect(param1:BattleEffect) : void
      {
         if(effectsBar == null)
         {
            effectsBar = new BattleHeroEffectStatusBar();
            this.graphics.addChild(effectsBar.graphics);
         }
         effectsBar.addStatus(param1);
      }
      
      private function createHpBarStyle(param1:Boolean) : void
      {
         this.hpBarStyleRed = param1;
         if(param1)
         {
            hpBar = AssetStorage.rsx.battle_interface.create_battleBarRed();
         }
         else
         {
            hpBar = AssetStorage.rsx.battle_interface.create_battleBarGreen();
         }
         hpBar.defineMaxValue(1);
         hpBar.x = -(int(hpBar.width * 0.5));
         hpBar.y = -195;
         hpBar.visible = false;
         hpBarVisibility = 0;
         graphics.addChild(hpBar);
      }
      
      private function disposeHpBar() : void
      {
         hpBar.dispose();
      }
      
      private function positionBar(param1:BattleHpBarClip, param2:int) : void
      {
         param1.x = -(int(param1.width * 0.5));
         param1.y = -195 + (param2 + 1) * 13;
      }
   }
}
