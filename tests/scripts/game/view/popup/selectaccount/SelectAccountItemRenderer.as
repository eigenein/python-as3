package game.view.popup.selectaccount
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.mediator.gui.popup.chat.userinfo.ChatUserClanIconClip;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.ToolTipSimpleTextView;
   import idv.cjcat.signals.Signal;
   
   public class SelectAccountItemRenderer extends ListItemRenderer
   {
       
      
      private var mediator:SelectAccountItemRendererMediator;
      
      private var clip:SelectAccountItemRendererClip;
      
      private var clanFlag:ChatUserClanIconClip;
      
      private var _signal_select:Signal;
      
      public function SelectAccountItemRenderer()
      {
         _signal_select = new Signal(ServerListUserValueObject);
         super();
         mediator = new SelectAccountItemRendererMediator();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TooltipHelper.removeTooltip(clanFlag.graphics);
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function set data(param1:Object) : void
      {
         if(data != param1)
         {
            .super.data = param1;
            mediator.accountData = param1 as ServerListUserValueObject;
            invalidate("data");
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SelectAccountItemRendererClip,"select_account_renderer");
         addChild(clip.graphics);
         clanFlag = new ChatUserClanIconClip();
         clanFlag.setupEmpty();
         clip.layout_content.addChildAt(clanFlag.graphics,0);
         clip.action_btn_1.signal_click.add(onSelect);
         clip.action_btn_2.signal_click.add(onSelect);
      }
      
      override protected function draw() : void
      {
         if(isInvalid("data") && clip && mediator.accountData)
         {
            clip.title_tf.text = mediator.nickname;
            clip.portrait.setData(mediator.accountData);
            clip.id_tf.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_LABEL_ID") + " " + mediator.id;
            clip.heroes_tf.text = Translate.translateArgs("UI_DIALOG_MERGE_HEROES_COUNT",mediator.countHeroes);
            clip.power_tf.text = Translate.translate("UI_DIALOG_RATING_TYPE_FULL_POWER") + " " + mediator.power;
            clip.vip_tf.text = Translate.translateArgs("UI_COMMON_VIP",mediator.vipLevel);
            clip.recommended_tf.text = Translate.translate("UI_DIALOG_MERGE_RECOMMENDED");
            clip.action_btn_1.label = Translate.translate("UI_DIALOG_MERGE_SELECT");
            clip.action_btn_2.label = Translate.translate("UI_DIALOG_MERGE_SELECT");
            clip.recommended_tf.visible = index == 0;
            clip.action_btn_1.graphics.visible = index == 0;
            clip.action_btn_2.graphics.visible = index > 0;
            if(mediator.userClanID)
            {
               clanFlag.setupFlag(mediator.userClanInfo.icon);
               (clip.layout_content.layout as HorizontalLayout).gap = 5;
            }
            else
            {
               (clip.layout_content.layout as HorizontalLayout).gap = 20;
            }
            clip.server_tf.text = mediator.serverName;
            TooltipHelper.addTooltip(clanFlag.container,new TooltipVO(ToolTipSimpleTextView,mediator.clanName));
         }
         super.draw();
      }
      
      private function onSelect() : void
      {
         if(mediator.accountData)
         {
            signal_select.dispatch(mediator.accountData);
         }
      }
   }
}
