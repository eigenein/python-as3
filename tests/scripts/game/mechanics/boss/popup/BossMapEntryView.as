package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiMarker;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import game.assets.HeroRsxAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.boss.mediator.BossMapEntryState;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import idv.cjcat.signals.Signal;
   import starling.display.Sprite;
   
   public class BossMapEntryView implements IButtonView
   {
      
      public static const BOSS_SCALE:Number = 0.4;
      
      public static const ANIMATION_SPEED_FAST:Number = 2;
      
      public static const ANIMATION_SPEED_SLOW:Number = 1;
       
      
      private var point_chest_center:Point;
      
      private var point_chest:Point;
      
      private var _isSelected:Boolean = false;
      
      private var buttonController:TouchButtonController;
      
      private var buttonAnimation:GuiAnimation;
      
      private var asset:RsxGuiAsset;
      
      private var state:BossMapEntryState;
      
      private var bossAsset:HeroRsxAsset;
      
      private var chestContainer:GuiMarker;
      
      private var chestBigContainer:GuiMarker;
      
      private var bossContainer:GuiMarker;
      
      private var ui:GuiMarker;
      
      private var chest_center:GuiMarker;
      
      private var bossContainerFilter:Sprite;
      
      private var bossSelectionAnimation:GuiAnimation;
      
      private var chestSelectionAnimation:GuiAnimation;
      
      private var bossAnimation:GuiAnimation;
      
      private var openedChestAnimation:GuiAnimation;
      
      private var closedChestAnimation:GuiAnimation;
      
      private var currentChestAnimation:GuiAnimation;
      
      public const signal_clickAttack:Signal = new Signal();
      
      public const signal_clickRaid:Signal = new Signal();
      
      public const signal_clickChestOpen:Signal = new Signal();
      
      public function BossMapEntryView(param1:GuiMarker, param2:GuiMarker, param3:GuiMarker, param4:GuiMarker, param5:GuiMarker)
      {
         bossContainerFilter = new Sprite();
         super();
         this.chest_center = param5;
         this.ui = param4;
         this.chestContainer = param1;
         this.chestBigContainer = param2;
         this.bossContainer = param3;
         this.bossContainer.graphics.touchable = false;
         asset = AssetStorage.rsx.dialog_boss;
         point_chest_center = new Point(param5.graphics.x,param5.graphics.y);
         point_chest = new Point(param1.graphics.x,param1.graphics.y);
      }
      
      public function dispose() : void
      {
      }
      
      public function clear() : void
      {
         bossContainer.container.removeChildren();
         bossContainerFilter.removeChildren();
         chestContainer.container.removeChildren();
         chestBigContainer.container.removeChildren();
         ui.container.removeChildren();
      }
      
      public function setHeroAsset(param1:HeroRsxAsset) : void
      {
         this.bossAsset = param1;
         trySetupBossAnimation();
      }
      
      public function setChestActive() : void
      {
         state = BossMapEntryState.CHEST;
         setChestCurrentAnimation();
         chestContainer.graphics.visible = false;
         chestBigContainer.graphics.visible = true;
      }
      
      public function setBossActive() : void
      {
         state = BossMapEntryState.BOSS;
         trySetupBossAnimation();
         setChestClosedAnimation();
         chestContainer.graphics.visible = true;
         chestBigContainer.graphics.visible = false;
      }
      
      public function setChestOpened() : void
      {
         setChestOpenedAnimation();
         chestContainer.graphics.visible = true;
         chestBigContainer.graphics.visible = false;
      }
      
      public function setChestClosed() : void
      {
         setChestClosedAnimation();
         chestContainer.graphics.visible = true;
         chestBigContainer.graphics.visible = false;
      }
      
      public function setBossLevel(param1:uint) : void
      {
         var _loc2_:BossLevelClip = asset.create(BossLevelClip,"boss_level");
         _loc2_.graphics.x = 20;
         _loc2_.graphics.y = -30;
         _loc2_.tf.text = String(param1);
         chestContainer.container.addChild(_loc2_.graphics);
      }
      
      public function setBossUI(param1:uint, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc8_:BossUIClip = asset.create(BossUIClip,"boss_ui_universal");
         if(!param2 && param5)
         {
            if(Translate.has("UI_BOSS_UI_UNIVERSAL_TF_DAILY_REWARD_TOMORROW"))
            {
               _loc8_.tf_raid_tomorrow.text = Translate.translate("UI_BOSS_UI_UNIVERSAL_TF_DAILY_REWARD_TOMORROW");
            }
            else
            {
               _loc8_.tf_raid_tomorrow.visible = false;
            }
         }
         else
         {
            _loc8_.tf_raid_tomorrow.visible = false;
         }
         if(param6)
         {
            setBossActive();
         }
         bossContainer.graphics.visible = param6;
         if(param3)
         {
            setChestActive();
         }
         else if(param5)
         {
            setChestOpened();
            if(param6)
            {
            }
         }
         if(!param6 && !param5)
         {
            setChestClosed();
         }
         if(param6)
         {
            chestContainer.graphics.x = point_chest.x;
            chestContainer.graphics.y = point_chest.y;
         }
         else
         {
            chestContainer.graphics.x = point_chest_center.x;
            chestContainer.graphics.y = point_chest_center.y;
         }
         setSelected(param6 && (param4 || param2));
         var _loc9_:* = param6;
         if(_loc9_)
         {
            _loc8_.playback.gotoAndStop(1);
         }
         else
         {
            _loc8_.playback.gotoAndStop(0);
         }
         _loc8_.btn_green.graphics.visible = param2 || param3 || param4;
         _loc8_.marker.graphics.visible = param2 || param3 || param7;
         _loc8_.btn_brown.graphics.visible = !_loc8_.btn_green.graphics.visible && param5;
         _loc8_.tf_level.text = Translate.translateArgs("UI_DIALOG_BOSS_LEVEL",param1);
         if(param2)
         {
            _loc8_.btn_green.signal_click.add(handler_raid);
            _loc8_.btn_green.label = Translate.translate("UI_DIALOG_BOSS_FARM_REWARD");
         }
         else if(param4)
         {
            _loc8_.btn_green.label = Translate.translate("UI_DIALOG_BOSS_ATTACK");
            _loc8_.btn_green.signal_click.add(handler_attack);
         }
         else if(param3)
         {
            _loc8_.btn_green.signal_click.add(handler_chestOpen);
            _loc8_.btn_green.label = Translate.translate("UI_DIALOG_BOSS_OPEN");
         }
         else
         {
            _loc8_.btn_brown.signal_click.add(handler_chestOpen);
            _loc8_.btn_brown.label = Translate.translate("UI_DIALOG_BOSS_OPEN");
         }
         if(!param4 && !param2 && !param5)
         {
            _loc8_.tf_avaliable.text = Translate.translate("UI_DIALOG_BOSS_UNAVAILABLE_STATE");
         }
         else
         {
            _loc8_.tf_avaliable.visible = false;
         }
         ui.container.addChild(_loc8_.graphics);
      }
      
      public function setSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(bossSelectionAnimation)
         {
            bossSelectionAnimation.graphics.visible = _isSelected;
         }
         if(chestSelectionAnimation)
         {
            chestSelectionAnimation.graphics.visible = _isSelected;
         }
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = NaN;
         if(param1 == "hover")
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 1;
         }
         if(bossSelectionAnimation)
         {
            bossSelectionAnimation.playbackSpeed = _loc3_;
         }
         if(chestSelectionAnimation)
         {
            chestSelectionAnimation.playbackSpeed = _loc3_;
         }
         if(currentChestAnimation)
         {
            currentChestAnimation.playbackSpeed = _loc3_;
         }
         if(closedChestAnimation)
         {
            closedChestAnimation.playbackSpeed = _loc3_;
         }
         if(bossAnimation)
         {
            bossAnimation.playbackSpeed = _loc3_;
         }
      }
      
      public function click() : void
      {
      }
      
      protected function trySetupBossAnimation() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(bossAsset)
         {
            bossContainer.container.removeChildren();
            if(!bossSelectionAnimation)
            {
               bossSelectionAnimation = asset.create(GuiAnimation,"map_boss_back_animation");
               bossSelectionAnimation.playbackSpeed = 1;
               if(buttonController)
               {
                  buttonController.dispose();
               }
            }
            buttonController = new TouchButtonController(bossContainer.container,this);
            bossContainer.container.addChild(bossSelectionAnimation.graphics);
            bossSelectionAnimation.graphics.visible = _isSelected;
            if(bossAnimation)
            {
               bossAnimation.dispose();
               bossAnimation = null;
            }
            if(!bossAnimation)
            {
               bossAnimation = new GuiAnimation();
            }
            _loc1_ = new Node(0);
            _loc1_.state = new State();
            _loc1_.state.matrix = new Matrix(0.4,0,0,0.4);
            _loc2_ = bossAsset.data.getClipByName("POSE");
            if(_loc2_ == null)
            {
               _loc2_ = bossAsset.data.getClipByName("IDLE");
            }
            _loc1_.clip = _loc2_;
            bossAnimation.setNode(_loc1_);
            bossContainerFilter.addChild(bossAnimation.graphics);
            bossContainer.container.addChild(bossContainerFilter);
         }
      }
      
      protected function setChestClosedAnimation() : void
      {
         chestContainer.container.removeChildren();
         if(!closedChestAnimation)
         {
            closedChestAnimation = asset.create(GuiAnimation,"map_chest_closed_animation");
            closedChestAnimation.graphics.touchable = false;
         }
         chestContainer.container.addChild(closedChestAnimation.graphics);
      }
      
      protected function setChestClosedCurrentAnimation() : void
      {
         chestContainer.container.removeChildren();
         if(!closedChestAnimation)
         {
            closedChestAnimation = asset.create(GuiAnimation,"map_chest_closed_current_animation");
            currentChestAnimation.graphics.touchable = false;
         }
         chestContainer.container.addChild(closedChestAnimation.graphics);
      }
      
      protected function setChestOpenedAnimation() : void
      {
         chestContainer.container.removeChildren();
         if(!openedChestAnimation)
         {
            openedChestAnimation = asset.create(GuiAnimation,"map_chest_opened_animation");
         }
         chestContainer.container.addChild(openedChestAnimation.graphics);
      }
      
      protected function setChestCurrentAnimation() : void
      {
         chestBigContainer.container.removeChildren();
         if(!currentChestAnimation)
         {
            currentChestAnimation = asset.create(GuiAnimation,"map_chest_current_animation");
         }
         if(!chestSelectionAnimation)
         {
            chestSelectionAnimation = asset.create(GuiAnimation,"map_chest_selection_animation");
            chestSelectionAnimation.playbackSpeed = 1;
            if(buttonController)
            {
               buttonController.dispose();
            }
         }
         buttonController = new TouchButtonController(chestBigContainer.container,this);
         chestBigContainer.container.addChild(chestSelectionAnimation.graphics);
         chestBigContainer.container.addChild(currentChestAnimation.graphics);
      }
      
      private function handler_raid() : void
      {
         signal_clickRaid.dispatch();
      }
      
      private function handler_attack() : void
      {
         signal_clickAttack.dispatch();
      }
      
      private function handler_chestOpen() : void
      {
         signal_clickChestOpen.dispatch();
      }
   }
}
