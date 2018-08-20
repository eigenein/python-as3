package loader.web
{
   import engine.loader.SVNProps;
   import flash.display.Sprite;
   import flash.system.Capabilities;
   
   public class VersionedClientLoader extends Sprite
   {
       
      
      protected const SVN_PROPS:SVNProps = new SVNProps();
      
      public function VersionedClientLoader()
      {
         SVN_PROPS.DATE = "$Date: 2017-02-13 13:45:16 +0300 (Пн, 13 фев 2017) $";
         SVN_PROPS.REVISION = "$Revision: 3146 $";
         SVN_PROPS.URL = "$URL: https://svn-local.studionx.ru/heroes_client/src_web/trunk/loader/web/VersionedClientLoader.as $";
         if(Capabilities.playerType == "StandAlone" && stage)
         {
            stage.addChild(SVN_PROPS.createTextField());
         }
         super();
      }
   }
}
