/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.logic.cache;

/**
 *
 */
public interface LogicCacheConfig {
    public enum Features {
        MAX_ELEMENTS_IN_MEMORY,
        MAX_ELEMENTS_ON_DISK,
        DEFAULT_TTL,
        USING_DISK_STORE,
        DISABLE
    }

    Integer getMaxElementsInMemory() throws UnsupportedOperationException;

    Integer getMaxElementsOnDisk() throws UnsupportedOperationException;

    Long getDefaultTTL() throws UnsupportedOperationException;

    boolean isUsingDiskStore() throws UnsupportedOperationException;

    boolean isDisabled() throws UnsupportedOperationException;

    void setDefaultTTL(Long ttl) throws UnsupportedOperationException;

    void setMaxElementsInMemory(Integer maxInMem) throws UnsupportedOperationException;

    void setMaxElementsOnDisk(Integer maxOnDisk) throws UnsupportedOperationException;

    void setUsingDiskStore(boolean isDiskStore) throws UnsupportedOperationException;

    void setDisabled(boolean disabled) throws UnsupportedOperationException;

    boolean isRestartNeeded();
    
    boolean getFeature(Features name);

}
