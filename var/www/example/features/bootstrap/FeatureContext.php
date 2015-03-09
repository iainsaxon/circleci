<?php

use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\MinkExtension\Context\MinkContext;


/**
 * Defines application features from the specific context.
 */
class FeatureContext extends MinkContext implements SnippetAcceptingContext
{

    /** @var \Behat\MinkExtension\Context\MinkContext */
    private $screenshotCompareContext;

    /**
     * @BeforeScenario
     *
     * @param BeforeScenarioScope $scope
     */
    public function gatherContexts(BeforeScenarioScope $scope)
    {
        $environment = $scope->getEnvironment();

        $this->screenshotCompareContext = $environment->getContext('Cevou\Behat\ScreenshotCompareExtension\Context\ScreenshotCompareContext');
    }

    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

    /**
     * This works for Selenium and other real browsers that support screenshots.
     *
     * @Then /^take a screenshot$/
     */
    public function takeAScreenshot()
    {
        $this->saveScreenshot();
    }

    /**
     * Save a screenshot
     *
     * @param null $filename
     * @param null $filepath
     */
    public function saveScreenshot($filename = null, $filepath = null)
    {
        $filename = $filename ?: sprintf('%s_%s_%s.%s', $this->getMinkParameter('browser_name'), date('c'), uniqid('', true), 'png');
        $filepath = $filepath ? $filepath : (ini_get('upload_tmp_dir') ? ini_get('upload_tmp_dir') : sys_get_temp_dir());
        file_put_contents($filepath . '/' . $filename, $this->getSession()->getScreenshot());

        if (PHP_OS === "Darwin" && PHP_SAPI === "cli") {
            exec('open -a "Preview.app" ' . $filepath . '/' . $filename);
        }
    }

}
