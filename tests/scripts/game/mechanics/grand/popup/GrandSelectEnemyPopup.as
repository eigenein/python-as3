package game.mechanics.grand.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.grand.mediator.GrandSelectEnemyPopupMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.arena.ArenaEnemyPanelClip;
   
   public class GrandSelectEnemyPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:GrandSelectEnemyPopupMediator;
      
      private var clip:GrandSelectEnemyPopupClip;
      
      public function GrandSelectEnemyPopup(param1:GrandSelectEnemyPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.enemyList.unsubscribe(handler_enemies);
         var _loc3_:int = 0;
         var _loc2_:* = clip.enemy;
         for each(var _loc1_ in clip.enemy)
         {
            TooltipHelper.removeTooltip(_loc1_.graphics);
            _loc1_.signal_pick.remove(mediator.action_select);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_grand_select_enemy();
         addChild(clip.graphics);
         clip.title = Translate.translate("UI_DIALOG_GRAND_SELECT_ENEMY_TITLE");
         mediator.enemyList.onValue(handler_enemies);
         clip.button_refresh.initialize(Translate.translate("UI_DIALOG_ARENA_REROLL"),mediator.action_refresh);
         clip.button_close.signal_click.add(mediator.close);
         var _loc3_:int = 0;
         var _loc2_:* = clip.enemy;
         for each(var _loc1_ in clip.enemy)
         {
            _loc1_.signal_pick.add(mediator.action_select);
         }
         centerPopupBy(clip.dialog_frame.graphics);
      }
      
      protected function handler_enemies(param1:Vector.<PlayerArenaEnemy>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
