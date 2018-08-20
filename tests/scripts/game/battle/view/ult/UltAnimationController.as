package game.battle.view.ult
{
   import battle.data.BattleSkillDescription;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.battle.gui.BattleGuiDarkScreen;
   import game.battle.view.BattleScene;
   import game.battle.view.BattleSceneLayers;
   import game.battle.view.hero.HeroView;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class UltAnimationController
   {
       
      
      public const graphics:DisplayObjectContainer = new Sprite();
      
      public const back:ZSortedSprite = new ZSortedSprite();
      
      private var defaultHeroContainer:DisplayObjectContainer;
      
      private var ultPauseDuration:Number;
      
      private var ultCasts:Vector.<UltAnimationCast>;
      
      private var selectedHeroPosition:Point;
      
      private var selectedHeroR:Number = 0;
      
      private var _timeStopped:Boolean = false;
      
      private var _showBlackScreen:Boolean = false;
      
      private var _nonUltTimeStop:Boolean = false;
      
      private var darkScreenContainer:Sprite;
      
      private var darkScreen:BattleGuiDarkScreen;
      
      private var scene:BattleScene;
      
      private var sAncestors:Vector.<DisplayObject>;
      
      private var sAncestorsCount:int = 0;
      
      public function UltAnimationController()
      {
         selectedHeroPosition = new Point();
         darkScreenContainer = new Sprite();
         darkScreen = new BattleGuiDarkScreen(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight);
         sAncestors = new Vector.<DisplayObject>(0);
         super();
         ultCasts = new Vector.<UltAnimationCast>();
         ultPauseDuration = 0;
         graphics.visible = false;
         graphics.addChild(darkScreenContainer);
         var _loc1_:Quad = new Quad(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight,0);
         back.addChild(_loc1_);
         back.visible = false;
      }
      
      public function get timeStopped() : Boolean
      {
         return _timeStopped;
      }
      
      public function get nonUltTimeStop() : Boolean
      {
         return _nonUltTimeStop;
      }
      
      public function getSkillIsInCast(param1:BattleSkillDescription) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = ultCasts.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = ultCasts[_loc3_];
            if(_loc2_.skill == param1 && _loc2_.stopTime)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function startUlt(param1:UltAnimationCast) : void
      {
         add(param1);
      }
      
      public function init(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:Number, param4:BattleScene) : void
      {
         this.defaultHeroContainer = param1;
         this.scene = param4;
         var _loc5_:* = param3;
         graphics.scaleY = _loc5_;
         graphics.scaleX = _loc5_;
         darkScreen.alpha.onValue(handler_darkScreenAlpha);
         darkScreenContainer.x = -param2.x;
         darkScreenContainer.y = -param2.y;
         back.x = -param2.x;
         back.y = -param2.y;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Number = NaN;
         var _loc3_:Boolean = false;
         _nonUltTimeStop = false;
         var _loc6_:Boolean = false;
         var _loc8_:HeroView = null;
         var _loc5_:int = ultCasts.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = ultCasts[_loc7_];
            _loc2_.advanceTime(param1);
            if(_loc2_.showBlackScreen)
            {
               _loc6_ = true;
               if(_loc2_.hero != null)
               {
                  _loc8_ = _loc2_.hero;
               }
            }
            if(_loc2_.stopTime)
            {
               _loc3_ = true;
               if(_loc2_.hero == null)
               {
                  _nonUltTimeStop = true;
               }
            }
            if(_loc2_.finished)
            {
               if(_loc2_.hero != null)
               {
                  _loc2_.hero.transform.scale = 1;
               }
               _loc7_--;
               _loc5_--;
               ultCasts[_loc7_] = ultCasts[_loc5_];
            }
            _loc7_++;
         }
         ultCasts.length = _loc5_;
         if(_loc5_ == 0)
         {
            graphics.visible = false;
         }
         if(_loc3_ != _timeStopped)
         {
            _timeStopped = _loc3_;
         }
         if(_loc6_ != _showBlackScreen)
         {
            _showBlackScreen = _loc6_;
            if(_showBlackScreen)
            {
               darkScreen.show(darkScreenContainer);
            }
            else
            {
               darkScreen.hide();
               darkScreen.clear();
            }
         }
         if(_loc8_)
         {
            setSelectedHeroPosition(_loc8_,0.05);
            _loc4_ = 120 + (1 - darkScreen.alpha.value) * 300;
            darkScreen.setupTarget(selectedHeroPosition.x,selectedHeroPosition.y,selectedHeroR,_loc4_);
            back.x = -back.parent.x;
            back.z = _loc8_.position.z - 17 - 3.14159265358979;
         }
      }
      
      protected function add(param1:UltAnimationCast) : void
      {
         ultCasts.push(param1);
         if(param1.stopTime)
         {
            _timeStopped = true;
         }
         if(param1.showBlackScreen)
         {
            if(param1.hero)
            {
               setSelectedHeroPosition(param1.hero,1);
            }
         }
         graphics.visible = true;
      }
      
      private final function findCommonParent(param1:DisplayObject, param2:DisplayObject) : DisplayObject
      {
         sAncestorsCount = 0;
         var _loc3_:* = param1;
         while(_loc3_)
         {
            sAncestorsCount = Number(sAncestorsCount) + 1;
            sAncestors[Number(sAncestorsCount)] = _loc3_;
            _loc3_ = _loc3_.parent;
         }
         _loc3_ = param2;
         while(_loc3_ && sAncestors.indexOf(_loc3_) == -1)
         {
            _loc3_ = _loc3_.parent;
         }
         sAncestors.length = 0;
         return _loc3_;
      }
      
      protected function setSelectedHeroPosition(param1:HeroView, param2:Number) : void
      {
         var _loc3_:* = null;
         if(param1 != null && param1.transform.visible && findCommonParent(param1.transform.parent,darkScreenContainer))
         {
            _loc3_ = param1.transform.getBounds(darkScreenContainer);
            selectedHeroPosition.x = selectedHeroPosition.x * (1 - param2) + param2 * (_loc3_.x + _loc3_.width * 0.5);
            selectedHeroPosition.y = selectedHeroPosition.y * (1 - param2) + param2 * (_loc3_.y + _loc3_.height * 0.5);
            selectedHeroR = selectedHeroR * (1 - param2) + param2 * (50 + 0.5 * Math.sqrt(_loc3_.width * _loc3_.width + _loc3_.height * _loc3_.height) * 0.5);
         }
      }
      
      private function handler_darkScreenAlpha(param1:Number) : void
      {
         if(param1)
         {
            back.visible = true;
            back.alpha = param1 * 0.8;
         }
         else
         {
            back.visible = false;
            back.alpha = 0;
         }
         scene.textController.container.alpha = 1 - param1 * param1 * 4;
         scene.layers.statusContainer.alpha = (1 - param1 * param1 * 4) * BattleSceneLayers.statusLayerAlpha;
      }
   }
}
