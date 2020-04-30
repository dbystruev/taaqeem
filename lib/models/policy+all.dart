//
//  lib/models/plan+all.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:taaqeem/models/policy.dart';
import 'package:taaqeem/models/policy_section.dart';

extension AllPolicies on Policy {
  static List<Policy> get local => [
        Policy('Privacy policy', sections: [
          PolicySection('Privacy Policy', text: '''Taaqeem is committed to protecting and respecting your privacy. This Privacy Policy sets out how we collect and process personal information about you when you visit our website, all visitors who access our website or services through any mobile application (together, "Website") and when you use our products and services (our "Services"), or when you otherwise do business or make contact with us.

By visiting and/or ordering services on this Website, you agree and, where required, you consent to the collection, use and transfer of your information as set out in this policy.

This privacy policy applies only to the Website, and does not extend to the websites of any other companies or organizations to which we link, and specifically address our obligations in respect of applicable laws in the United Arab Emirates ("UAE").

Please read this policy carefully to understand how we handle and treat your personal information.'''),
          PolicySection('What information do we collect?', text: '''We may collect and process the following personal information from you:

Information you provide to us: We collect personal information when you voluntarily provide us with such information in the course of using our website or Services. For example, when you register to use our Services, we will collect your first name, last Name, Email address, password, phone number, business information, and billing details.

Information we collect when you do business with us: We may process your personal information when you do business with us – for example, as a customer or prospective customer, or as a vendor, supplier, consultant, or other third party. For example, we may hold your business contact information and financial account information (if any) and other communications you have with us for the purposes of maintaining our business relations with you.

Information we automatically collect: We may also collect certain technical information by automatic means when you visit our website, such as IP address, browser type and operating system, referring URLs, your use of our website, and other clickstream data. We collect this information automatically through the use of various technologies, such as cookies.'''),
          PolicySection('Do we use cookies?', text: '''Yes. Cookies are small files that a site or its service provider transfers to your computers hard drive through your Web browser (if you allow) that enables the sites or service providers systems to recognize your browser and capture and remember certain information.

We use cookies to understand and save your preferences for future visits, to advertise to you on other sites, and to compile aggregate data about site traffic and site interaction so that we can offer better site experiences and tools in the future.

You have the ability to accept or decline cookies. Most web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies. If you delete or decline cookies, some features of the Sites may not work or may not work as designed. For more information on cookies and how to disable them, you can consult the information provided by the Interactive Advertising Bureau at www.allaboutcookies.org.

However, if you choose to disable cookies, you may be unable to access certain parts of our site. A banner asking you to accept our cookies policy will be displayed upon the first visit to our website (or the first visit after you delete your cookies). Unless you have adjusted your browser setting so that it will refuse cookies and/or you have not accepted our cookies policy, our system will issue cookies when you log on to our site'''),
          PolicySection('What do we use your information for?', text: '''The personal information we collect from you may be used in one of the following ways:

1. Contacting you (including for promotional purposes).

2. Uploading your content (raw data or otherwise) to our Service as you request.

3. Permitting you to update, edit, and manage your content on our Service.

4. Communicating with you about your account or transactions with us (including service related announcements) and send you information about features and enhancements on our Service.

5. Informing you about changes to our policies.

6. Optimizing or improving our products, services, and operations.

7. To process transactions and to provide Services to our customers and end-users.

8. Personalizing content and experiences on our Service, including providing you reports, recommendations, and feedback based on your preferences.

9. Other uses in accordance with our Terms of Use or any other purpose disclosed to you at the time we collect the information.

10. Please note that by submitting comments and feedback regarding the Website and the services, you consent to us to use such comments and feedback on the Website and in any marketing or advertising materials. We will only identify you for this purpose by your first name and the city in which you reside.'''),
          PolicySection('Do we disclose any information to outside parties?', text: '''We may share your information with third parties in certain circumstances:

1. Third parties process information such as credit card payments and provide support services related to payments for us. In addition, we may need to provide your information to Cleaning Service Provider that you have placed your order using our Services. By submitting your personal data, you agree to this transfer, storing or processing. We will take all steps reasonably necessary to ensure that your data is treated securely and in accordance with this privacy policy.

2. We engage certain trusted third parties to perform functions and provide services to us, including cloud hosting services, off-site backups, email service providers, and customer support providers. We will only share your personal information with third parties to the extent necessary to perform these functions, in accordance with the purposes set out in this Privacy Policy and applicable laws.

3. In the event of a corporate sale, merger, reorganization, dissolution, or similar event, your personal information may be sold, disposed of, transferred, or otherwise disclosed as part of that transaction.

4. We may also use or disclose Personal Information if required to do so by law or in the good-faith belief that such action is necessary to (a) conform to applicable law or comply with legal process served on us or the Service; (b) protect and defend our rights or property, the Service or our users, and (c) act under emergency circumstances to protect the personal safety of us, our affiliates, Partner Service Provider, or the users of the Service or the public. This includes exchanging information with other companies and organizations for fraud protection.

5. We may use and share aggregated non-personal information with third parties for marketing, advertising, and analytics purposes.

6. We do not sell or trade your personal information to third parties.'''),
          PolicySection('What steps are taken to keep personal infomation secure?', text: '''We are concerned about ensuring the security of your Personal Information. We exercise great care in providing secure transmission of your information from your device to our servers. Personal Information collected by our Service is stored in secure operating environments that are not available to the public. Our security procedures mean that we may occasionally request proof of identity before we disclose your Personal Information to you. Please understand, however, that while we try our best to safeguard your Personal Information once we receive it, no transmission of data over the Internet or any other public network can be guaranteed to be 100% secure.'''),
          PolicySection('Data retention', text: '''We may retain your personal information as long as you continue to use the Services, have an account with us, or for as long as is necessary to fulfil the purposes outlined in the policy. You can ask to close your account by contacting us at the details above, and we will delete your personal information on request.

We may, however, retain personal information for an additional period as is permitted or required under applicable laws, for legal, tax, or regulatory reasons, or for legitimate and lawful business purposes.'''),
          PolicySection('Changes to this privacy policy', text: '''If we decide to change our privacy policy, we will post those changes on this page, and/or update the Privacy Policy modification date below.'''),
          PolicySection('Contact', text: '''If you have any queries and requests relating to our use of your information or Taaqeem's Privacy Policy, you may email us at info@taaqeem.ae.'''),
        ]),
        Policy('Terms of Service', sections: [
          PolicySection('Terms of Service', text: '''Thank you for using Taaqeem. We're really excited that you have decided to access and use our services, which is made up of our Online Service Ordering Platform connected to our Partner Cleaning Service Provider's Messenger and Facebook accounts ("Ordering Platform"), which is accessed via Facebook ("Facebook"), Messenger mobile App or website ("Messenger").The Ordering Platform and the Cleaning Service Provider Dashboard comprises, and is collectively referred to as, the "Services."

We provide our Services to you subject to the following Terms of Use, which may be updated by us from time to time without notice to you. By browsing the public areas or by accessing and using the Service, you acknowledge that you have read, understood, and agree to be legally bound by the terms and conditions of these Terms of Use and the terms and conditions of our Privacy Policy, which is hereby incorporated by reference (collectively, this "Agreement."). If you do not agree to any of these terms, then please do not use the Service.'''),
          PolicySection('01. Information about us', text: '''Taaqeem is an Online Service Ordering Platform that utilizes Facebook and Messenger to allow you to find and order from your favorite Cleaning Service Providers, and much more.

Although you are able to place orders through the Services using either Facebook or Messenger, Taaqeem itself does not sell the service contained in your order, is not a party to any such transaction, and has no control over the quality or safety of the products. Your order is between you and the Partner Cleaning Service Provider from which you order. We do not investigate or verify the type of service, service standards, or any descriptions, statements, or representations made by the Cleaning Service Providers. By using the Services, you agree that you understand that Taaqeem is not responsible for any statements or omissions concerning the service contained in your order.'''),
          PolicySection('02. Purpose', text: '''The purpose of our Services is to provide a simple and convenient services to you, linking you to the Partner Cleaning Service Provider and allowing you to order cleaning service from them using our platform. Taaqeem provides the Ordering Platform to our Partner Cleaning Service Providers to promote their services, and delivers it to you.'''),
          PolicySection('03. Price and payment / refunds', text: '''The price of any type of cleaning service will be listed on our Services and defined by the Partner Cleaning Service Providers. Prices are liable to change at any time, but changes will not affect orders in respect of which you have been presented with the Confirmation message, save in the case of an obvious pricing mistake, whereby the Partner Cleaning Service Provider will notify you as soon as they can about the pricing issue. The relevant Partner Cleaning Service Provider will normally verify prices as part of the order process.

All refunds are subject to the refund policies of the Cleaning Service Providers from which you order. If you contact us seeking a refund, we cannot – and will not – process any refund until we receive the approval from the applicable Cleaning Service Provider. We will use reasonable efforts to request and obtain refunds when appropriate.'''),
          PolicySection('04. Intellectual property', text: '''The Services contain material, such as software, text, graphics, images, sound recordings, audiovisual works, and other material provided by or on behalf of Taaqeem (collectively referred to as the "Content"). The Content may be owned by us or by third parties. The Content is protected by copyright laws and treaties around the world. Unauthorized use of the Content may violate copyright, trademark, and other laws.

You have no rights in or to the Content, and you will not use the Content except as permitted under this Agreement.

You may not sell, transfer, assign, license, sublicense, or modify the Content or reproduce, display, publicly perform, make a derivative version of, distribute, or otherwise use the Content in any way for any public or commercial purpose. The use or posting of the Content on any other website or in a networked computer environment for any purpose is expressly prohibited.'''),
          PolicySection('05. Communications to Taaqeem and user submissions', text: '''You should not e-mail us any content that contains confidential information. With respect to all e-mails you send to us, including but not limited to, feedback, questions, comments, suggestions, and the like, we shall be free to use any ideas, concepts, know-how, or techniques contained in your communications for any purpose whatsoever, including but not limited to, the development, production, and marketing of products and services that incorporate such information.

You retain all copyrights and other intellectual property rights in and to anything you post to the Services. You do, however, grant us an irrevocable, non-exclusive, worldwide, perpetual, royalty-free license to use, modify, copy, distribute, publish, perform, sublicense, and create derivative works from all submissions you provide to us in any media now known or hereafter devised and for any purpose.'''),
          PolicySection('06. Our liability', text: '''Although we take our customers' satisfaction very seriously, if you have any problems with your service order, please contact the Cleaning Service Provider directly. Your order is between you and the Cleaning Service Provider from which your order, and Taaqeem is not an actual party to any such order.

In connection with any warranty, contract, or common law tort claims: we shall not be liable for any incidental or consequential damages, lost profits, or damages resulting from lost data or business interruption resulting from the use of inability to access and use the services or the content, even if we have been advised of the possibility of such damages.

Some jurisdictions do not allow the exclusion of certain warranties. Therefore, some of the above limitations on warranties in this section may not apply to you.

The services and/or the content may contain technical inaccuracies, typographical errors, or omission. We are not responsible for any such typographical, technical, pricing, or other errors listed on or omitted from the services and/or the Content. The services and the content contain information on our participating Cleaning Service Providers' products, not all of which are available in every location. A reference to a product on the services or in the content does not imply that such product is or will be available in your location. We reserve the right to make changes, corrections, and/or improvements to the services and the content at any time without notice.

We reserve the right to cancel or modify an order where it appears that a customer has engaged in fraudulent or inappropriate activity or under other circumstances where it appear that the order contains or resulted from a mistake or error. In addition, we reserve the right to report any fraudulent or inappropriate conduct to appropriate authorities at out discretion.'''),
          PolicySection('07. Indemnification', text: '''You agree to defend, indemnify, and hold us and our officers, directors, employees, successors, licensees, and assigns harmless from and against any claims, actions, or demands, including, without limitation, reasonable legal and accounting fees, arising or resulting from your breach of this Agreement or your misuse of the Content or the Services. We shall provide notice to you of any such claim, suit, or proceeding and shall assist you, at your expense, in defending any such claim, suit, or proceeding. We reserve the right to assume the exclusive defense and control of any matter that is subject to indemnification under this section. In such case, you agree to cooperate with any reasonable requests assisting our defense of such matter.'''),
          PolicySection('08. Events outside our control', text: '''No party shall be liable to the other for any delay or non-performance of its obligations under this Agreement arising from any cause beyond its control including, without limitation, any of the following: act of God, governmental act, war, fire, flood, explosion or civil commotion. For the avoidance of doubt, nothing in clause 08 shall excuse the Customer from any payment obligations under this Agreement.'''),
          PolicySection('09. Waiver', text: '''Neither you, Taaqeem nor the Partner Cleaning Service Provider shall be responsible to the others for any delay or non-performance of its obligations under this agreement arising from any cause beyond its control including, without limitation, any of the following: act of God, governmental act, war, fire, flood, explosion or civil commotion.'''),
          PolicySection('10. External sites', text: '''The Services may contain links to third-party websites ("External Sites"). These links are provided solely as a convenience to you and not as an endorsement by us of the content on such External Sites. The content of such External Sites is developed and provided by others. You should contact the site administrator or webmaster for those External Sites if you have any concerns regarding such links or any content located on such External Sites. We are not responsible for the content of any linked External Sites and do not make any representations regarding the content or accuracy of materials on such External Sites. You should take precautions when downloading files from all websites to protect your computer from viruses and other destructive programs. If you decide to access linked External Sites, you do so at your own risk.'''),
          PolicySection('11.Termination of the Agreement', text: '''We may terminate your use of the Services and deny you access to the Services in our sole discretion for any reason or no reason, including your: (i) violation of these Terms; or (ii) lack of use of the Services. You agree that any termination of your access to the Services may be affected without prior notice, and acknowledge and agree that we may immediately deactivate or delete your account and all related information and/or bar any further access to your account or the Services. If you use the Services in violation of these Terms, we may, in our sole discretion, retain all data collected from your use of the Services. Further, you agree that we shall not be liable to you or any third party for the discontinuation or termination of your access to the Services'''),
          PolicySection('12. Law and jurisdiction', text: '''This Agreement shall be governed by, construed and enforced in accordance with the laws of the UAE, without giving effect to any conflict of law provisions. Any dispute arising under this Agreement shall be resolved exclusively by an appropriate court of law in the UAE.'''),
          PolicySection('13. Miscellaneous', text: '''Our failure to act on or enforce any provision of the Agreement shall not be construed as a waiver of that provision or any other provision in this Agreement. No waiver shall be effective against us unless made in writing, and no such waiver shall be construed as a waiver in any other or subsequent instance. Except as expressly agreed by us and you in writing, this Agreement constitutes the entire Agreement between you and us with respect to the subject matter, and supersedes all previous or contemporaneous agreements, whether written or oral, between the parties with respect to the subject matter. The section headings are provided merely for convenience and shall not be given any legal import. This Agreement will inure to the benefit of our successors, assigns, licensees, and sublicensees.'''),
        ]),
      ];
}
