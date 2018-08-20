package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.boss.mediator.BossChestPopupValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.sound.SoundSource;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   
   public class BossChestPanelClip extends GuiClipNestedContainer
   {
      
      private static var _sound:SoundSource;
      
      private static var _soundShort:SoundSource;
       
      
      private var items:Vector.<InventoryItem>;
      
      private var _staticBasePosition:Number;
      
      private var _vo:BossChestPopupValueObject;
      
      public const signal_item:Signal = new Signal(BossChestPanelClip);
      
      public const signal_dispose:Signal = new Signal(BossChestPanelClip);
      
      public var chest_closed:BossChestPanelClosedClip;
      
      public var chest_opened:BossChestPanelOpenedClip;
      
      public var chest_free:BossChestPanelFreeClip;
      
      public var block_static:BossChestPanelBlockStatic;
      
      public function BossChestPanelClip()
      {
         items = new Vector.<InventoryItem>();
         super();
      }
      
      public static function get sound() : SoundSource
      {
         if(!_sound)
         {
            _sound = AssetStorage.sound.bossChest;
         }
         return _sound;
      }
      
      public static function get soundShort() : SoundSource
      {
         if(!_soundShort)
         {
            _soundShort = AssetStorage.sound.bossChestShort;
         }
         return _soundShort;
      }
      
      public function dispose() : void
      {
         signal_dispose.dispatch(this);
         signal_dispose.clear();
         signal_item.clear();
         graphics.removeFromParent(true);
         sound.stop();
         soundShort.stop();
      }
      
      public function get staticBasePosition() : Number
      {
         return _staticBasePosition;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(chest_opened)
         {
            chest_opened.container.touchable = false;
         }
         if(chest_closed)
         {
            chest_closed.container.touchable = false;
         }
         _staticBasePosition = block_static.graphics.y;
      }
      
      public function setValueObject(param1:BossChestPopupValueObject, param2:Boolean) : void
      {
         this._vo = param1;
         if(param1.isFree)
         {
            items.push(param1.reward);
            selectCurrentClip(chest_free);
            initStaticBlock();
            block_static.item_reward_free.setData(items[0]);
            block_static.item_reward.graphics.visible = false;
            block_static.item_reward_pack_1.graphics.visible = false;
            block_static.item_reward_pack_2.graphics.visible = false;
            block_static.bg_label.graphics.visible = true;
            block_static.tf_label.text = Translate.translate("UI_DIALOG_BOSS_CHEST_FREE");
            if(param2)
            {
               chest_free.setStatic(false);
            }
            else
            {
               chest_free.setStatic(true);
            }
         }
         else
         {
            block_static.item_reward_free.graphics.visible = false;
            block_static.tf_label.graphics.visible = false;
            block_static.bg_label.graphics.visible = false;
            if(param1.isOpened)
            {
               items.push(param1.reward);
               selectCurrentClip(chest_opened);
               chest_opened.setOpened();
               setItems();
            }
            else
            {
               selectCurrentClip(chest_closed);
               clearItem();
               if(param2)
               {
                  chest_closed.setStatic(false);
               }
               else
               {
                  chest_closed.setStatic(true);
               }
            }
         }
      }
      
      public function setCurrent() : void
      {
         if(!_vo.isFree)
         {
            if(!_vo.isOpened)
            {
               chest_closed.animate();
            }
         }
      }
      
      public function open(param1:Vector.<InventoryItem>, param2:Boolean) : void
      {
         this.items = param1;
         if(_vo.isFree)
         {
            block_static.animation_get_free.show(block_static.container);
            block_static.animation_get_free.playOnceAndHide();
            handler_chestOpenAnimationComplete();
         }
         else
         {
            selectCurrentClip(chest_opened);
            chest_opened.startOpenAnimation(param2);
            chest_opened.chest_start.signal_completed.add(handler_chestOpenAnimationComplete);
         }
         if(_vo.isFree || param2)
         {
            soundShort.play();
         }
         else
         {
            sound.play();
         }
      }
      
      protected function initStaticBlock() : void
      {
         block_static.graphics.visible = true;
         block_static.graphics.parent.addChild(block_static.graphics);
      }
      
      protected function setItems() : void
      {
         block_static.graphics.visible = true;
         block_static.graphics.parent.addChild(block_static.graphics);
         block_static.item_reward.graphics.visible = !_vo.isFree && items.length == 1;
         block_static.item_reward_pack_1.graphics.visible = !_vo.isFree && items.length > 1;
         block_static.item_reward_pack_2.graphics.visible = !_vo.isFree && items.length > 1;
         if(items.length > 1)
         {
            block_static.item_reward_pack_1.setData(items[0]);
            block_static.item_reward_pack_2.setData(items[1]);
         }
         else
         {
            block_static.item_reward.setData(items[0]);
         }
      }
      
      protected function clearItem() : void
      {
         block_static.graphics.visible = false;
      }
      
      protected function selectCurrentClip(param1:GuiClipNestedContainer) : void
      {
         var _loc3_:DisplayObject = param1.graphics;
         var _loc4_:Array = [chest_opened.graphics,chest_closed.graphics,chest_free.graphics];
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc2_ in _loc4_)
         {
            if(_loc2_ != null)
            {
               if(_loc2_ == _loc3_)
               {
                  if(!_loc2_.parent)
                  {
                     container.addChild(_loc2_);
                  }
               }
               else if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
            }
         }
      }
      
      private function handler_chestOpenAnimationComplete() : void
      {
         setItems();
         signal_item.dispatch(this);
      }
   }
}
