package game.mediator.gui.popup.clan
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.ClanUserInfoValueObject;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.clan.editicon.ClanIconClip;
   
   public class ClanIconWithFrameClip extends ClipButton
   {
       
      
      private const clanFlag:ClanIconClip = AssetStorage.rsx.clan_icons.createFlagClip();
      
      private const _tooltipVO:TooltipVO = new TooltipVO(TooltipTextView,"");
      
      private var empty:ClipSprite;
      
      private var clanInfo:ClanUserInfoValueObject;
      
      public var layout_flag:ClipLayout;
      
      public function ClanIconWithFrameClip()
      {
         layout_flag = ClipLayout.none();
         super();
         signal_click.add(handler_click);
      }
      
      public function dispose() : void
      {
         hideTooltip();
         if(empty && !empty.graphics.parent)
         {
            empty.graphics.dispose();
         }
         if(clanFlag && !clanFlag.graphics.parent)
         {
            clanFlag.graphics.dispose();
         }
      }
      
      public function setData(param1:ClanUserInfoValueObject, param2:Boolean = true) : void
      {
         layout_flag.removeChildren();
         this.clanInfo = param1;
         if(param1)
         {
            setIconAndTitle(param1.icon,param1.title,param2);
         }
         else
         {
            setIconAndTitle(null,null,param2);
         }
      }
      
      public function setIconAndTitle(param1:ClanIconValueObject, param2:String, param3:Boolean = true) : void
      {
         if(param1)
         {
            hideTooltip();
            showTooltip(param2);
            isEnabled = true;
            graphics.visible = true;
            layout_flag.addChild(clanFlag.graphics);
            var _loc4_:* = 0.45;
            clanFlag.graphics.scaleY = _loc4_;
            clanFlag.graphics.scaleX = _loc4_;
            AssetStorage.rsx.clan_icons.setupFlag(clanFlag,param1);
         }
         else
         {
            hideTooltip();
            isEnabled = false;
            if(param3)
            {
               graphics.visible = true;
               if(!empty)
               {
                  empty = AssetStorage.rsx.clan_icons.createEmptyClip();
               }
               layout_flag.addChild(empty.graphics);
            }
            else
            {
               graphics.visible = false;
            }
         }
      }
      
      private function showTooltip(param1:String) : void
      {
         _tooltipVO.hintData = param1;
         TooltipHelper.addTooltip(graphics,_tooltipVO);
      }
      
      private function hideTooltip() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
      
      private function handler_click() : void
      {
         Game.instance.navigator.navigateToClanById(clanInfo.id);
      }
   }
}
