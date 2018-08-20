package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.utils.MathUtil;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.GamePopupManager;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.popup.common.resourcepanel.PopupResourcePanelItem;
   import org.osflash.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.filters.ColorMatrixFilter;
   import starling.textures.Texture;
   
   public class ArtifactFlyingDropLayer implements IAnimatable
   {
       
      
      private const pool:Vector.<FlyingDropInstance> = new Vector.<FlyingDropInstance>();
      
      private const active:Vector.<FlyingDropInstance> = new Vector.<FlyingDropInstance>();
      
      public var baseParabolaHeight:Number = 80;
      
      public var simplifiedAnimation:Boolean = false;
      
      public const graphics:Sprite = new Sprite();
      
      public const overlay:Sprite = new Sprite();
      
      public const signal_item:Signal = new Signal(InventoryItem);
      
      public function ArtifactFlyingDropLayer()
      {
         super();
         Starling.juggler.add(this);
      }
      
      public function dispose() : void
      {
         signal_item.removeAll();
         Starling.juggler.remove(this);
         var _loc3_:int = 0;
         var _loc2_:* = pool;
         for each(var _loc1_ in pool)
         {
            _loc1_.view.dispose();
         }
      }
      
      public function addChestItem(param1:Number, param2:Number, param3:InventoryItem, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc10_:Texture = AssetStorage.inventory.getItemGUIIconTexture(param3.item);
         var _loc9_:FlyingDropInstance = getItem();
         _loc9_.lifetime = 0;
         _loc9_.x = param1;
         _loc9_.y = param2;
         _loc9_.scale = param8;
         _loc9_.depth = param7;
         _loc9_.startPoint.x = _loc9_.x;
         _loc9_.startPoint.y = _loc9_.y;
         _loc9_.floatingPoint.x = param4;
         _loc9_.floatingPoint.y = param5;
         _loc9_.endTime = param6 + 100;
         var _loc14_:InventoryItemIcon = AssetStorage.rsx.popup_theme.create_inventory_item_icon();
         _loc14_.setItem(param3);
         _loc9_.view = _loc14_.graphics;
         _loc9_.type = FlyingDropInstance.TYPE_HERO;
         if(!simplifiedAnimation)
         {
            _loc11_ = new ColorMatrixFilter();
            _loc11_.adjustSaturation(-1);
            _loc11_.adjustBrightness(0.7);
            _loc9_.view.filter = _loc11_;
         }
         _loc9_.width = _loc9_.view.width;
         _loc9_.height = _loc9_.view.height;
         _loc9_.delay = param6;
         _loc9_.flyDuration = param7;
         _loc9_.item = param3;
         var _loc12_:PopupResourcePanelItem = GamePopupManager.instance.resourcePanel.panel.getPanelByItem(param3.item);
         if(_loc12_)
         {
            _loc13_ = _loc12_.graphics.getBounds(_loc12_.graphics.stage);
            _loc9_.target.x = _loc13_.x + 18;
            _loc9_.target.y = _loc13_.y + 18;
         }
         else
         {
            _loc9_.target.x = Starling.current.stage.stageWidth - 10;
            _loc9_.target.y = 10;
         }
         active.push(_loc9_);
         graphics.addChildAt(_loc9_.view,0);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = active.length;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc6_:* = active[_loc4_];
            active[_loc4_ - _loc2_] = _loc6_;
            _loc5_ = _loc6_;
            _loc5_.lifetime = _loc5_.lifetime + param1;
            if(_loc5_.lifetime > _loc5_.endTime)
            {
               if(_loc5_.item)
               {
                  signal_item.dispatch(_loc5_.item);
               }
               _loc2_++;
               pool[pool.length] = _loc5_;
               graphics.removeChild(_loc5_.view,true);
            }
            else
            {
               updateItem(_loc5_,param1);
            }
            _loc4_++;
         }
         active.length = _loc3_ - _loc2_;
      }
      
      protected function getItem() : FlyingDropInstance
      {
         if(pool.length > 0)
         {
            return pool.pop();
         }
         return new FlyingDropInstance();
      }
      
      protected function updateItem(param1:FlyingDropInstance, param2:Number) : void
      {
         var _loc8_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param1.lifetime < param1.delay)
         {
            param1.view.visible = false;
         }
         else
         {
            _loc8_ = param1.endTime;
            param1.view.visible = true;
            _loc3_ = param1.delay + param1.flyDuration;
            if(param1.lifetime < param1.delay + param1.flyDuration)
            {
               _loc4_ = Number((param1.lifetime - param1.delay) / param1.flyDuration);
               _loc4_ = Number(0.5 * _loc4_ + 0.5 * MathUtil.mapPower(_loc4_,3));
               _loc6_ = baseParabolaHeight + param1.depth * 60;
               _loc5_ = _loc4_ * _loc4_ * _loc4_;
               param1.x = param1.startPoint.x * (1 - _loc5_) + param1.floatingPoint.x * _loc5_;
               param1.y = param1.startPoint.y * (1 - _loc4_) + param1.floatingPoint.y * _loc4_ - _loc4_ * (1 - _loc4_) * 4 * _loc6_;
               if(param1.lifetime > param1.delay + param1.flyDuration - 0.15 && param1.view.filter)
               {
                  param1.view.filter.dispose();
                  param1.view.filter = null;
               }
            }
            else
            {
               _loc4_ = 1;
               param1.x = param1.floatingPoint.x;
               param1.y = param1.floatingPoint.y;
            }
            if(param1.lifetime > _loc3_ && param1.lifetime - param2 <= _loc3_)
            {
               if(simplifiedAnimation)
               {
                  param1.endTime = param1.lifetime;
               }
               else
               {
                  param1.endTime = param1.lifetime + setBangAnimation(param1.view as DisplayObjectContainer);
                  if(param1.item)
                  {
                     signal_item.dispatch(param1.item);
                     param1.item = null;
                  }
               }
            }
            _loc7_ = (0.3 + _loc4_ * _loc4_ * 0.7 * param1.scale) * 0.8;
            param1.view.alpha = MathUtil.clamp(_loc4_ * 2,0,1);
            var _loc9_:* = _loc7_;
            param1.view.scaleY = _loc9_;
            param1.view.scaleX = _loc9_;
            param1.view.x = param1.x - param1.width * _loc7_ * 0.5;
            param1.view.y = param1.y - param1.height * _loc7_ * 0.5;
         }
      }
      
      private function getTimeEase(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = (param1 - param2) / param3;
         if(_loc5_ < 0 || _loc5_ != _loc5_)
         {
            return 0;
         }
         if(_loc5_ > 1)
         {
            return 1;
         }
         return _loc5_ * (1 - param4) + _loc5_ * _loc5_ * param4;
      }
      
      private function getOscillationDecay(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param2)
         {
            return 0;
         }
         var _loc5_:Number = MathUtil.clamp(1 - Math.sqrt((param1 - param2) / param3),0,1);
         return Math.sin(param4 * (param1 - param2)) * _loc5_;
      }
      
      private function setBangAnimation(param1:DisplayObjectContainer) : Number
      {
         param1.removeChildren(0,-1,true);
         overlay.addChild(param1);
         var _loc2_:GuiAnimation = AssetStorage.rsx.popup_theme.create(GuiAnimation,"BangReward");
         param1.addChild(_loc2_.graphics);
         _loc2_.graphics.x = _loc2_.graphics.x + _loc2_.graphics.width * 0.5;
         _loc2_.graphics.y = _loc2_.graphics.y + _loc2_.graphics.height * 0.5;
         _loc2_.playOnce();
         return (_loc2_.lastFrame + 1) / 60;
      }
   }
}

import flash.geom.Point;
import game.model.user.inventory.InventoryItem;
import starling.display.DisplayObject;

class FlyingDropInstance
{
   
   public static var TYPE_COIN:int = 0;
   
   public static var TYPE_HERO:int = 1;
    
   
   public var view:DisplayObject;
   
   public var x:Number;
   
   public var y:Number;
   
   public var width:Number;
   
   public var height:Number;
   
   public var scale:Number;
   
   public var velocity:Point;
   
   public var startPoint:Point;
   
   public var floatingPoint:Point;
   
   public var target:Point;
   
   public var lifetime:Number = 0;
   
   public var delay:Number = 0;
   
   public var flyDuration:Number = 0;
   
   public var endTime:Number = 0;
   
   public var depth:Number = 0;
   
   public var type:int = 0;
   
   public var item:InventoryItem;
   
   function FlyingDropInstance()
   {
      velocity = new Point();
      startPoint = new Point();
      floatingPoint = new Point();
      target = new Point();
      super();
   }
}
