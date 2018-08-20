package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.utils.MathUtil;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.popup.common.resourcepanel.PopupResourcePanelItem;
   import org.osflash.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class BossFlyingDropLayer implements IAnimatable
   {
      
      public static const TYPE_DEFAULT:int = -1;
      
      public static const TYPE_ITEM_WITH_FRAME:int = 0;
      
      public static const TYPE_GUI_ICON:int = 1;
       
      
      private const pool:Vector.<BossFlyingDropInstance> = new Vector.<BossFlyingDropInstance>();
      
      private const active:Vector.<BossFlyingDropInstance> = new Vector.<BossFlyingDropInstance>();
      
      private var duration:Number;
      
      public const graphics:Sprite = new Sprite();
      
      public const signal_item:Signal = new Signal(InventoryItem);
      
      public function BossFlyingDropLayer(param1:Number)
      {
         super();
         Starling.juggler.add(this);
         this.duration = param1;
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
      
      public function addChestItem(param1:Number, param2:Number, param3:InventoryItem, param4:Number, param5:Number, param6:Number, param7:Number, param8:int = -1) : void
      {
         var _loc14_:* = null;
         var _loc12_:* = null;
         var _loc10_:Texture = AssetStorage.inventory.getItemGUIIconTexture(param3.item);
         var _loc9_:BossFlyingDropInstance = getItem();
         _loc9_.lifetime = 0;
         _loc9_.x = param1;
         _loc9_.y = param2;
         _loc9_.depth = param7;
         _loc9_.startPoint.x = _loc9_.x;
         _loc9_.startPoint.y = _loc9_.y;
         _loc9_.floatingPoint.x = _loc9_.x + param4;
         _loc9_.floatingPoint.y = _loc9_.y + param5;
         _loc9_.floatingTimeCoefficient = 0.1 + Math.random() * 0.1;
         _loc9_.oscillationDuration = 0.3 + 0.5 * Math.random();
         var _loc13_:Boolean = true;
         if(param8 == -1)
         {
            _loc13_ = !(param3.item is UnitDescription) && _loc10_ != AssetStorage.rsx.popup_theme.missing_texture;
         }
         else if(param8 == 1)
         {
            _loc13_ = true;
         }
         else if(param8 == 0)
         {
            _loc13_ = false;
         }
         if(_loc13_)
         {
            _loc9_.view = new Image(_loc10_);
            _loc9_.type = BossFlyingDropInstance.TYPE_COIN;
         }
         else
         {
            _loc14_ = AssetStorage.rsx.popup_theme.create_inventory_item_icon();
            _loc14_.setItem(param3);
            _loc9_.view = _loc14_.graphics;
            _loc9_.type = BossFlyingDropInstance.TYPE_HERO;
         }
         _loc9_.width = _loc9_.view.width;
         _loc9_.height = _loc9_.view.height;
         _loc9_.scale = 1;
         _loc9_.delay = param6;
         _loc9_.item = param3;
         var _loc11_:PopupResourcePanelItem = GamePopupManager.instance.resourcePanel.panel.getPanelByItem(param3.item);
         if(_loc11_)
         {
            _loc12_ = _loc11_.graphics.getBounds(_loc11_.graphics.stage);
            _loc9_.target.x = _loc12_.x + 18;
            _loc9_.target.y = _loc12_.y + 18;
         }
         else
         {
            _loc9_.target.x = Starling.current.stage.stageWidth - 10;
            _loc9_.target.y = 10;
         }
         active.push(_loc9_);
         graphics.addChild(_loc9_.view);
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
            if(_loc5_.lifetime > duration + _loc5_.delay)
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
      
      protected function getItem() : BossFlyingDropInstance
      {
         if(pool.length > 0)
         {
            return pool.pop();
         }
         return new BossFlyingDropInstance();
      }
      
      protected function updateItem(param1:BossFlyingDropInstance, param2:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc12_:* = NaN;
         _loc12_ = 1.6;
         var _loc8_:* = NaN;
         _loc8_ = 0.125;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc15_:* = NaN;
         var _loc11_:* = NaN;
         var _loc10_:* = NaN;
         if(param1.lifetime < param1.delay)
         {
            param1.view.visible = false;
         }
         else
         {
            _loc6_ = param1.delay + duration;
            param1.view.visible = true;
            _loc4_ = param1.delay * 0.3;
            _loc16_ = duration - 0.5 + _loc4_ - param1.delay * 0.5;
            _loc7_ = _loc16_ * param1.floatingTimeCoefficient;
            _loc3_ = _loc16_ + param1.oscillationDuration;
            _loc5_ = getOscillationDecay(param1.lifetime,param1.delay + _loc7_,_loc3_,_loc12_);
            _loc13_ = _loc5_ * _loc8_;
            _loc14_ = param1.lifetime > _loc16_ + param1.delay && param1.lifetime - param2 <= _loc16_ + param1.delay;
            if(param1.lifetime < _loc16_ + param1.delay)
            {
               _loc9_ = getTimeEase(param1.lifetime,param1.delay,_loc16_ * 0.25,-0.9);
               _loc15_ = 50;
               param1.x = param1.startPoint.x * (1 - _loc9_) + param1.floatingPoint.x * _loc9_;
               param1.y = param1.startPoint.y * (1 - _loc9_) + param1.floatingPoint.y * _loc9_ + _loc9_ * (1 - _loc9_) * 4 * _loc15_;
            }
            else if(param1.type == BossFlyingDropInstance.TYPE_HERO)
            {
               if(_loc14_)
               {
                  setBangAnimation(param1.view as DisplayObjectContainer);
                  if(param1.item)
                  {
                     signal_item.dispatch(param1.item);
                     param1.item = null;
                  }
               }
            }
            else
            {
               _loc9_ = getTimeEase(param1.lifetime,param1.delay + _loc16_,_loc6_ - _loc16_ - param1.delay,1);
               param1.x = param1.floatingPoint.x * (1 - _loc9_) + param1.target.x * _loc9_;
               param1.y = param1.floatingPoint.y * (1 - _loc9_) + param1.target.y * _loc9_;
            }
            param1.x = param1.x + _loc13_ * (param1.floatingPoint.x - param1.startPoint.x);
            param1.y = param1.y + _loc13_ * (param1.floatingPoint.y - param1.startPoint.y);
            param1.scale = 0.8 * param1.depth;
            if(param1.type == BossFlyingDropInstance.TYPE_HERO)
            {
               _loc10_ = 1;
            }
            else
            {
               _loc11_ = 0.3;
               if(param1.lifetime > _loc6_ - _loc11_)
               {
                  _loc10_ = Number(MathUtil.clamp((_loc6_ - param1.lifetime) / _loc11_,0,1));
                  param1.scale = param1.scale * (0.6 + 0.4 * _loc10_);
               }
               else
               {
                  _loc10_ = Number(MathUtil.clamp((param1.lifetime - param1.delay) / 0.25,0,1));
                  param1.scale = param1.scale * _loc10_;
               }
            }
            param1.view.alpha = _loc10_ * (0.8 + 0.2 * param1.depth);
            var _loc17_:* = param1.scale;
            param1.view.scaleY = _loc17_;
            param1.view.scaleX = _loc17_;
            param1.view.x = param1.x - param1.width * param1.scale * 0.5;
            param1.view.y = param1.y - param1.height * param1.scale * 0.5;
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
         return Math.sin(2 * 3.14159265358979 * param4 * (param1 - param2)) * _loc5_;
      }
      
      private function setBangAnimation(param1:DisplayObjectContainer) : Number
      {
         param1.removeChildren(0,-1,true);
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

class BossFlyingDropInstance
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
   
   public var floatingTimeCoefficient:Number;
   
   public var oscillationDuration:Number;
   
   public var target:Point;
   
   public var lifetime:Number = 0;
   
   public var delay:Number = 0;
   
   public var depth:Number = 0;
   
   public var type:int = 0;
   
   public var item:InventoryItem;
   
   function BossFlyingDropInstance()
   {
      velocity = new Point();
      startPoint = new Point();
      floatingPoint = new Point();
      target = new Point();
      super();
   }
}
