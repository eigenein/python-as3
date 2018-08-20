package game.view.popup.activity
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mechanics.boss.popup.dropparticle.DropLayer;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovement;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementElasticStop;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementPoint;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementStop;
   import game.mechanics.boss.popup.dropparticle.DropParticleMovementToPointInTime;
   import game.mechanics.boss.popup.dropparticle.InventoryItemDropParticle;
   import game.mediator.gui.popup.GamePopupManager;
   import game.view.popup.common.resourcepanel.PopupResourcePanelItem;
   import starling.animation.Juggler;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class SpecialQuestEventDropLayer
   {
       
      
      private var dropLayer:DropLayer;
      
      private var juggler:Juggler;
      
      public const container:Sprite = new Sprite();
      
      private var p:Point;
      
      private var p2:Point;
      
      private var _matrix:Vector.<Number>;
      
      public function SpecialQuestEventDropLayer()
      {
         dropLayer = new DropLayer();
         juggler = new Juggler();
         p = new Point();
         p2 = new Point();
         _matrix = new <Number>[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
         super();
         dropLayer.graphics.addEventListener("enterFrame",handler_enterFrame);
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
      
      private function getBounds(param1:DisplayObject) : Rectangle
      {
         if(dropLayer.graphics.stage)
         {
            return param1.getBounds(dropLayer.graphics);
         }
         return param1.getBounds(dropLayer.graphics.stage);
      }
      
      public function init() : void
      {
      }
      
      public function advanceTime(param1:Number) : void
      {
         juggler.advanceTime(param1);
      }
      
      public function dropReward(param1:InventoryItemDescription, param2:int, param3:DisplayObject) : void
      {
         var _loc10_:* = null;
         var _loc18_:* = null;
         var _loc9_:int = 0;
         var _loc17_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc11_:* = null;
         if(param2 > 20)
         {
            param2 = Math.log(param2) / Math.log(10) * 15;
         }
         var _loc4_:Rectangle = getBounds(param3);
         var _loc16_:PopupResourcePanelItem = GamePopupManager.instance.resourcePanel.panel.getPanelByItem(param1);
         if(_loc16_ != null)
         {
            _loc10_ = _loc16_.icon_marker.graphics;
            _loc18_ = getBounds(_loc10_);
         }
         var _loc12_:Point = new Point();
         if(_loc18_)
         {
            _loc12_.x = _loc18_.x + _loc18_.width * 0.5 + 4;
            _loc12_.y = _loc18_.y + _loc18_.height * 0.5 + 4;
         }
         else
         {
            _loc12_ = graphics.globalToLocal(new Point(20,Starling.current.stage.stageHeight));
         }
         var _loc13_:Number = Math.random() * 3.14159265358979 * 2;
         var _loc14_:Point = null;
         _loc9_ = 0;
         while(_loc9_ < param2)
         {
            if(!_loc14_)
            {
               _loc14_ = new Point();
               _loc14_.x = _loc4_.x + _loc4_.width * 0.5;
               _loc14_.y = _loc4_.y + _loc4_.height * 0.5;
            }
            _loc17_ = new Vector.<DropParticleMovement>();
            _loc17_.push(new DropParticleMovementPoint(NaN,NaN,0,0));
            _loc17_.push(new DropParticleMovementStop(Math.random() * 0.08));
            _loc5_ = -_loc13_ * 0.5 + (-1.5 + Math.random() + Math.random() + Math.random()) * 0.5;
            _loc8_ = 300 + (Math.random() + Math.random()) / 2 * 350;
            _loc17_.push(new DropParticleMovementPoint(_loc14_.x,_loc14_.y,Math.cos(_loc5_) * _loc8_,Math.sin(_loc5_) * _loc8_));
            _loc11_ = new InventoryItemDropParticle(param1,1);
            if(_loc16_)
            {
               _loc15_ = 0.9 + Math.random() * 0.3;
               _loc17_.push(new DropParticleMovementElasticStop(0.2,4,1));
               _loc17_.push(new DropParticleMovementToPointInTime(_loc12_.x,_loc12_.y,_loc15_ - 0.3));
               dropLayer.add(_loc11_,_loc17_);
               var _loc19_:* = 0.85;
               _loc11_.graphics.scaleY = _loc19_;
               _loc11_.graphics.scaleX = _loc19_;
               Starling.juggler.tween(_loc11_.graphics,_loc15_ * 0.7,{
                  "delay":_loc15_ * 0.3,
                  "scaleX":0.6,
                  "scaleY":0.6,
                  "alpha":0.8,
                  "transition":"easeIn"
               });
            }
            else
            {
               _loc15_ = 0.7 + Math.random() * 0.3;
               _loc17_.push(new DropParticleMovementElasticStop(_loc15_,4));
               dropLayer.add(_loc11_,_loc17_);
               _loc19_ = 0.85;
               _loc11_.graphics.scaleY = _loc19_;
               _loc11_.graphics.scaleX = _loc19_;
               Starling.juggler.tween(_loc11_.graphics,_loc15_ * 0.2,{
                  "delay":_loc15_ * 0.3,
                  "scaleX":0.95,
                  "scaleY":0.95,
                  "transition":"easeInOut"
               });
               Starling.juggler.tween(_loc11_.graphics,_loc15_ * 0.5,{
                  "delay":_loc15_ * 0.5,
                  "scaleX":0.6,
                  "scaleY":0.6,
                  "alpha":0,
                  "transition":"easeIn"
               });
            }
            _loc9_++;
         }
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
      
      private function matrixAdd(param1:Number) : Vector.<Number>
      {
         var _loc2_:* = param1;
         _matrix[12] = _loc2_;
         _loc2_ = _loc2_;
         _matrix[6] = _loc2_;
         _matrix[0] = _loc2_;
         return _matrix;
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         advanceTime(Number(param1.data));
      }
   }
}
