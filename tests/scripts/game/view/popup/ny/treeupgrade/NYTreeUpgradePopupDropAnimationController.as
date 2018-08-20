package game.view.popup.ny.treeupgrade
{
   import engine.core.utils.MathUtil;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.command.rpc.ny.CommandNYTreeDecorate;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.mechanics.boss.popup.dropparticle.DropLayer;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovement;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementCallback;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementPoint;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementStopMapToDisplayObject;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementToPointInTime;
   import game.mechanics.boss.popup.dropparticle.InventoryItemDropParticle;
   import game.mediator.gui.popup.GamePopupManager;
   import game.view.gui.homescreen.HomeScreenNYVagonButton;
   import game.view.popup.common.resourcepanel.PopupResourcePanelItem;
   import starling.animation.Juggler;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.filters.ColorMatrixFilter;
   
   public class NYTreeUpgradePopupDropAnimationController
   {
       
      
      private var dropLayer:DropLayer;
      
      private var juggler:Juggler;
      
      private var mediator:NYTreeUpgradePopupMediator;
      
      private var clip:NYTreeUpgradePopupClip;
      
      private var treeAnimation:HomeScreenNYVagonButton;
      
      private var filterProgressBar:ColorMatrixFilter;
      
      private var filterTree:ColorMatrixFilter;
      
      private var _sizeTweenValue:Number = 0;
      
      private var _progressSizeTweenValue:Number = 0;
      
      private var _glowTweenValue:Number = 0;
      
      private var _progressGlowTweenValue:Number = 0;
      
      private var p:Point;
      
      private var p2:Point;
      
      private var _matrix:Vector.<Number>;
      
      public function NYTreeUpgradePopupDropAnimationController()
      {
         dropLayer = new DropLayer();
         juggler = new Juggler();
         filterProgressBar = new ColorMatrixFilter();
         filterTree = new ColorMatrixFilter();
         p = new Point();
         p2 = new Point();
         _matrix = new <Number>[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
         super();
      }
      
      public function dispose() : void
      {
         if(dropLayer)
         {
            dropLayer.dispose();
         }
         if(juggler)
         {
            juggler.advanceTime(1000);
            juggler.purge();
         }
      }
      
      public function get graphics() : DisplayObject
      {
         return dropLayer.graphics;
      }
      
      public function init(param1:NYTreeUpgradePopupMediator, param2:NYTreeUpgradePopupClip, param3:HomeScreenNYVagonButton) : void
      {
         this.mediator = param1;
         this.clip = param2;
         this.treeAnimation = param3;
         param2.progressbar_toys.fill.graphics.filter = filterProgressBar;
         param3.graphics.filter = filterTree;
      }
      
      public function advanceTime(param1:Number) : void
      {
         filterTree.matrix = matrixAdd(1 + 3 * MathUtil.clamp(_glowTweenValue,0,1));
         filterProgressBar.matrix = matrixAdd(1 + 3 * MathUtil.clamp(_progressGlowTweenValue,0,1));
         _glowTweenValue = _glowTweenValue * 0.8;
         _progressGlowTweenValue = _progressGlowTweenValue * 0.8;
         _sizeTweenValue = _sizeTweenValue * 0.9;
         _progressSizeTweenValue = _progressSizeTweenValue * 0.9;
         if(clip != null && mediator != null)
         {
            clip.progressbar_toys.value = mediator.treeExpPercent + _progressSizeTweenValue * 1.5;
         }
         if(treeAnimation != null && treeAnimation.animation != null)
         {
            var _loc2_:* = 1 + 0.1 * _sizeTweenValue;
            treeAnimation.animation.graphics.scaleY = _loc2_;
            treeAnimation.animation.graphics.scaleX = _loc2_;
         }
         juggler.advanceTime(param1);
      }
      
      public function animateDrop(param1:NY2018TreeDecorateAction, param2:int, param3:CommandNYTreeDecorate) : void
      {
         var _loc7_:int = 0;
         var _loc5_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:* = null;
         var _loc12_:* = undefined;
         var _loc8_:* = null;
         var _loc11_:int = param1.reward.outputDisplayFirst.amount / param1.cost.outputDisplayFirst.amount;
         var _loc4_:* = 0.8;
         var _loc13_:Number = _loc11_ == 1?0.5:0;
         var _loc16_:* = 1.5;
         var _loc14_:* = 0.25;
         var _loc15_:Point = new Point(Starling.current.nativeStage.mouseX,Starling.current.nativeStage.mouseY);
         var _loc6_:int = getDropAmount(param1.cost.outputDisplayFirst.amount * param2);
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = Math.random() * 2 * 3.14159265358979;
            _loc9_ = _loc4_ + Math.random() * 0.4 - 0.2;
            _loc10_ = getPointOnTree();
            _loc12_ = new Vector.<DropParticleMovement>();
            _loc12_.push(new DropParticleMovementPoint(_loc15_.x,_loc15_.y,Math.cos(_loc5_) * 200 - 300,Math.sin(_loc5_) * 500));
            _loc12_.push(new DropParticleMovementToPointInTime(_loc10_.x,_loc10_.y,_loc9_));
            _loc12_.push(new DropParticleMovementCallback(handler_exp));
            _loc12_.push(new DropParticleMovementStopMapToDisplayObject(_loc16_,treeAnimation.animation.graphics,clip.container));
            _loc8_ = new InventoryItemDropParticle(param1.cost.outputDisplayFirst.item,1);
            dropLayer.add(_loc8_,_loc12_);
            var _loc17_:* = 0.8;
            _loc8_.graphics.scaleY = _loc17_;
            _loc8_.graphics.scaleX = _loc17_;
            juggler.tween(_loc8_.graphics,_loc9_ * 0.5,{
               "scaleX":1,
               "scaleY":1,
               "transition":"easeIn",
               "rotation":_loc13_
            });
            juggler.tween(_loc8_.graphics,_loc9_ * 0.5,{
               "scaleX":0.5,
               "scaleY":0.5,
               "rotation":_loc13_ + 0.5,
               "transition":"easeIn",
               "delay":_loc9_ * 0.5
            });
            juggler.tween(_loc8_.graphics,0.4,{
               "delay":_loc9_,
               "rotation":_loc13_,
               "transition":"easeOutElastic"
            });
            juggler.tween(_loc8_.graphics,_loc14_,{
               "delay":_loc9_ + _loc16_ - _loc14_,
               "alpha":0
            });
            juggler.delayCall(dropReward,_loc9_ + 0.15,param1.reward.outputDisplayFirst.item,_loc11_);
            _loc7_++;
         }
         juggler.delayCall(applyTreeUpdate,_loc4_,param3);
      }
      
      private function getDropAmount(param1:int) : int
      {
         if(param1 > 1000)
         {
            return 20;
         }
         if(param1 > 100)
         {
            return 15 + param1 / 100;
         }
         if(param1 > 5)
         {
            return 5 + param1 / 10;
         }
         return param1;
      }
      
      private function getPointOnTree() : Point
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         do
         {
            p.x = clip.tree_container.graphics.x + (Math.random() * 160 - 80);
            p.y = clip.tree_container.graphics.y - Math.random() * 500;
            _loc1_ = clip.tree_container.graphics.x + (p.x - clip.tree_container.graphics.x) * 0.9;
            _loc2_ = p.y + 10;
            clip.container.localToGlobal(p,p2);
            treeAnimation.hitTest_image.graphics.globalToLocal(p2,p);
         }
         while(!treeAnimation.hitTest_image.graphics.hitTest(p,false));
         
         p.x = _loc1_;
         p.y = _loc2_;
         return p;
      }
      
      private function applyTreeUpdate(param1:CommandNYTreeDecorate) : void
      {
         mediator.applyCommandTreeUpdate(param1);
      }
      
      private function dropReward(param1:InventoryItemDescription, param2:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc13_:* = NaN;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc3_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc12_:* = undefined;
         var _loc6_:* = null;
         _progressSizeTweenValue = _progressSizeTweenValue * 0.8 + 0.2;
         _progressGlowTweenValue = _progressGlowTweenValue * 0.5 + 1;
         var _loc10_:PopupResourcePanelItem = GamePopupManager.instance.resourcePanel.panel.getPanelByItem(param1);
         if(_loc10_ == null)
         {
            return;
         }
         var _loc7_:DisplayObject = _loc10_.icon_marker.graphics;
         var _loc11_:Rectangle = _loc7_.getBounds(_loc7_.stage);
         if(_loc7_)
         {
            _loc4_ = _loc11_.x + _loc11_.width * 0.5 + 4;
            _loc13_ = Number(_loc11_.y + _loc11_.height * 0.5 + 4);
         }
         else
         {
            _loc4_ = Starling.current.stage.stageWidth - 10;
            _loc13_ = 10;
         }
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc8_ = getPointOnTree();
            _loc3_ = Math.random() * 2 * 3.14159265358979;
            _loc9_ = 0.7 + Math.random() * 0.1;
            _loc12_ = new Vector.<DropParticleMovement>();
            _loc12_.push(new DropParticleMovementPoint(_loc8_.x,_loc8_.y,Math.cos(_loc3_) * 50,Math.sin(_loc3_) * 200 - 600));
            _loc12_.push(new DropParticleMovementToPointInTime(_loc4_,_loc13_,_loc9_));
            _loc6_ = new InventoryItemDropParticle(param1,1);
            dropLayer.add(_loc6_,_loc12_);
            clip.container.addChildAt(_loc6_.graphics,3);
            var _loc14_:* = 0.6;
            _loc6_.graphics.scaleY = _loc14_;
            _loc6_.graphics.scaleX = _loc14_;
            Starling.juggler.tween(_loc6_.graphics,_loc9_ * 0.5,{
               "delay":_loc9_ * 0.5,
               "scaleX":0.85,
               "scaleY":0.85,
               "transition":"easeIn"
            });
            _loc5_++;
         }
      }
      
      private function handler_exp() : void
      {
         Starling.juggler.removeTweens(this);
         _sizeTweenValue = _sizeTweenValue * 0.8 + 0.2;
         _glowTweenValue = _glowTweenValue * 0.5 + 1;
      }
      
      private function matrixAdd(param1:Number) : Vector.<Number>
      {
         var _loc2_:* = param1;
         _matrix[12] = _loc2_;
         _loc2_ = _loc2_;
         _matrix[6] = _loc2_;
         _matrix[0] = _loc2_;
         return _matrix;
      }
   }
}
